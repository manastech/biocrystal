require "xml"

module Bio

  # BlastRecord class
  #
  # Represent a hit of a query Sequence in a SequenceDB on a blast run
  # is defined the attributes of the hit itself and an Array of Hsp (high scoring pairs).
  class BlastRecord # < Inherit General Hit Class?
    class Hsp # < Inherit General Hsp Class?
      getter num : Int32
      getter bit_score : Float64
      getter score : Int32
      getter evalue : Float64
      getter query_from : Int32
      getter query_to : Int32
      getter query_frame : Int32
      getter hit_frame : Int32
      getter identity : Int32
      getter postive : Int32
      getter gaps : Int32
      getter align_len : Int32
      getter qseq : String
      getter hseq : String
      getter midline : String

      def initialize(@num, @bit_score, @score, @evalue, @query_from, @query_to, @query_frame, \
                     @hit_frame, @identity, @postive, @gaps, @align_len, @qseq, @hseq, @midline)
      end
    end
    
    getter num : Int32
    getter id : String
    getter definition : String
    getter accession : String
    getter len : Int32
    getter hsps : Array(Hsp)

    def initialize(@num, @id, @definition, @accession, @len)
      @hsps = Array(Hsp).new
    end
  end

  # Blast class
  #
  # Class of abstract methods to be called to execute and wrap blast results.
  # Needs blast installed within the system. 
  class Blast
    enum DB
      NR              # Non-redundant protein sequences
      RP              # Reference proteins
      L               # Model organisms
      SP              # UniprotKB/Swiss-prot
      PAT             # Patented protein sequences
      PDB             # Protein DataBank
      ENV             # Metagenomic proteins
      TSA             # Transcriptome Shotgun Assembly proteins
    end

    # Run blast with a query Sequence against a local SequenceDB
    # ----
    # TODO: check ncbi-blast+ package is installed or raise error
    # FIXME: given tempfiles naming convention this method is implemented on real files.
    def Blast.run_local(db : SequenceDB, seq : Sequence)
      # Create tempfiles with fasta contents for db and seq
      query_file = File.new("query.fasta", "w")
      db_file = File.new("db.fasta", "w")
      
      File.write(query_file.path, seq.to_fasta_str)
      File.write(db_file.path, db.to_fasta_str)
      
      # Format db
      makedb_out= IO::Memory.new
      Process.run("makeblastdb", \
                  [\
                    "-in",db_file.path,  \
                    "-blastdb_version", "5", \
                    "-title", db_file.path, \
                    "-dbtype", db.sequence_type.to_blast_db_type, \
                    "-parse_seqids" \
                  ], \
                  output: makedb_out)

      # Run blast locally
      blast_out = IO::Memory.new
      Process.run("blastp", ["-db",db_file.path,"-query",query_file.path,"-outfmt","5"], output: blast_out)
      Process.run("rm", ["db.fasta"])
      Process.run("rm", ["db.fasta.pdb"])
      Process.run("rm", ["db.fasta.phr"])
      Process.run("rm", ["db.fasta.pin"])
      Process.run("rm", ["db.fasta.pog"])
      Process.run("rm", ["db.fasta.pos"])
      Process.run("rm", ["db.fasta.pot"])
      Process.run("rm", ["db.fasta.psq"])
      Process.run("rm", ["db.fasta.ptf"])
      Process.run("rm", ["db.fasta.pto"])
      Process.run("rm", ["query.fasta"])

      # Parse XML to BlastRecord instances
      hits=XML.parse(blast_out.to_s).xpath_nodes("//Hit") 

      ret = Array(BlastRecord).new

      hits.each do | hit |
        # Parse the hits
        hit_num       = hit.xpath_node("./Hit_num").as(XML::Node).text.to_i
        hit_id        = hit.xpath_node("./Hit_id").as(XML::Node).text
        hit_def       = hit.xpath_node("./Hit_def").as(XML::Node).text
        hit_accession = hit.xpath_node("./Hit_accession").as(XML::Node).text
        hit_len       = hit.xpath_node("./Hit_len").as(XML::Node).text.to_i

        blr = BlastRecord.new(hit_num, hit_id, hit_def, hit_accession, hit_len)
        ret << blr

        # For each hit parse its hsps (high scoring pairs)
        hit_hsps = hit.xpath_nodes("./Hit_hsps")
        hit_hsps.each do | hit_hsp |
          hsps = hit_hsp.xpath_nodes("./Hsp")
          hsps.each do | hsp |
            hsp_num         = hsp.xpath_node("./Hsp_num").as(XML::Node).text.to_i
            hsp_bit_score   = hsp.xpath_node("./Hsp_bit-score").as(XML::Node).text.to_f
            hsp_score       = hsp.xpath_node("./Hsp_score").as(XML::Node).text.to_i
            hsp_evalue      = hsp.xpath_node("./Hsp_evalue").as(XML::Node).text.to_f
            hsp_query_from  = hsp.xpath_node("./Hsp_query-from").as(XML::Node).text.to_i
            hsp_query_to    = hsp.xpath_node("./Hsp_query-to").as(XML::Node).text.to_i
            hsp_query_frame = hsp.xpath_node("./Hsp_query-frame").as(XML::Node).text.to_i
            hsp_hit_frame   = hsp.xpath_node("./Hsp_hit-frame").as(XML::Node).text.to_i
            hsp_identity    = hsp.xpath_node("./Hsp_identity").as(XML::Node).text.to_i
            hsp_postive     = hsp.xpath_node("./Hsp_positive").as(XML::Node).text.to_i
            hsp_gaps        = hsp.xpath_node("./Hsp_gaps").as(XML::Node).text.to_i
            hsp_align_len   = hsp.xpath_node("./Hsp_align-len").as(XML::Node).text.to_i
            hsp_qseq        = hsp.xpath_node("./Hsp_qseq").as(XML::Node).text
            hsp_hseq        = hsp.xpath_node("./Hsp_hseq").as(XML::Node).text
            hsp_midline     = hsp.xpath_node("./Hsp_midline").as(XML::Node).text
            
            blr.hsps << BlastRecord::Hsp.new(hsp_num, hsp_bit_score, hsp_score, hsp_evalue, hsp_query_from, \
                                       hsp_query_to, hsp_query_frame, hsp_hit_frame, hsp_identity, hsp_postive, \
                                       hsp_gaps, hsp_align_len, hsp_qseq, hsp_hseq, hsp_midline)
          end
        end
      end
      
      # Return array of BlastRecords
      ret
    end

    # Run blast with a query Sequence against an online database.
    # List of available online DBs are given by Blast::DB enum type.
    # ----
    # TODO: check ncbi-blast+ package is installed or raise error
    def Blast.run_ncbi(db : Blast::DB, seq : Sequence)
      raise "Not implemented"
    end
  end
end
