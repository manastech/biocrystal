
module Bio

  class BlastRecord

  end

  class Blast
    struct DB
      NR  = "nr"              # Non-redundant protein sequences
      RP  = "refseq_protein"  # Reference proteins
      L   = "landmark"        # Model organisms
      SP  = "swissprot"       # UniprotKB/Swiss-prot
      PAT = "pat"             # Patented protein sequences
      PDB = "pdb"             # Protein DataBank
      ENV = "env_nr"          # Metagenomic proteins
      TSA = "tsa_nr"          # Transcriptome Shotgun Assembly proteins
    end

    def Blast.run_local(db : SequenceDB, seq : Sequence)
      "blastp -db 6wwp.fasta -query 6wwp.fasta -outfmt 5"
    end

    # @requires: ncbi-blast+ package (on linux)
    # how to check install and throw error? 
    def Blast.run_ncbi(db : Blast::DB, seq : Sequence)
    end
  end
end