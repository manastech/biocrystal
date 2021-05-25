
module Bio

  enum SequenceType
    Protein
    Nucleotide
    Undefined

    def to_blast_db_type
      case self
      when .protein?
        return "prot"
      when .nucleotide?
        return "nucl"
      end
      return "String"
    end
  end

  # Sequence
  # 
  # A class representing a single sequence
  # with a list of its descriptors. 
  class Sequence
    property sequence : String
    property sequence_type : Bio::SequenceType
    getter id : String
    getter descriptors : Array(String)

    def initialize(@id, @sequence, @descriptors, @sequence_type = Bio::SequenceType::Undefined)
    end

    ### Class Methods ###
    def to_fasta_str
      ">#{id}\n#{sequence}\n"
    end
  end
  
  # Sequence DB
  # 
  # A class representing a collection of `Sequence` objects (i.e. a fasta file).
  # ----
  # TODO: Method that allow searching sequences based on certain descriptor.
  class SequenceDB
    getter descriptor_names : Array(String) | Nil
    property data : Hash(String, Sequence)
    getter sequence_type : SequenceType

    def initialize(@descriptor_names = nil , @sequence_type = Bio::SequenceType::Undefined)
      @data = Hash(String, Sequence).new
    end

    def records
      @data.keys
    end

    def record(id : String)
      @data[id]
    end

    def to_fasta_str
      ret = ""
      records.each do |rec|
        ret += @data[rec].to_fasta_str
      end
      ret
    end

  end
end

