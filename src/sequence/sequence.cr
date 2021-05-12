
module Bio

  # Sequence
  # 
  # A class representing a single sequence
  # with a list of its descriptors. 
  class Sequence
    getter descriptors : Array(String)
    property sequence : String

    def initialize(@descriptors, @sequence)
    end
  end
  
  # Sequence DB
  # 
  # A class representing a collection of `Sequence` objects (i.e. a fasta file).
  # 
  # TODO: Method that allow searching sequences based on certain descriptor.
  class SequenceDB
    getter descriptor_names : Array(String) | Nil
    property data : Hash(String, Sequence)

    def initialize(@descriptor_names = nil)
      @data = Hash(String, Sequence).new
    end
  end
  
end