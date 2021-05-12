
module Bio

  class BlastRecord

  end

  class Blast
    struct DB
      DB.NR  = "nr"              # Non-redundant protein sequences
      DB.RP  = "refseq_protein"  # Reference proteins
      DB.L   = "landmark"        # Model organisms
      DB.SP  = "swissprot"       # UniprotKB/Swiss-prot
      DB.PAT = "pat"             # Patented protein sequences
      DB.PDB = "pdb"             # Protein DataBank
      DB.ENV = "env_nr"          # Metagenomic proteins
      DB.TSA = "tsa_nr"          # Transcriptome Shotgun Assembly proteins
    end

    def Blast.run_local(db : SequenceDB, seq : Sequence)
      "blastp -db 6wwp.fasta -query 6wwp.fasta -outfmt 5"
    end

    # @requires: ncbi-blast+ package
    # how to check install and throw error? 
    def Blast.run_ncbi(db : Blast::DB, seq : Sequence)
    end
  end
end