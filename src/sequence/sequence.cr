
module Bio

  class Sequence
    getter description : Array(String)
    property sequence : String

    def initialize(@description, @sequence)
    end
  end
  
  class SequenceDB
    
    property data : Hash(String, Sequence)

    def initialize
      @data = Hash(String, Sequence).new
    end
  end
  
end