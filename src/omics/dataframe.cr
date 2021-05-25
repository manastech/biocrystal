require "num"

module Bio

  # DataFrame class
  #
  # Represents, i.e., the result of omics experiments, organized features vs observations with 
  # same notation that pandas, contaning only numerical data except in the header and/or
  # the index. Data is represented with num.cr tensor for perfomance.
  class DataFrame

    property index : Array(String) | Nil
    property columns : Array(String) | Nil
    getter data

    # Creates a new DataFrame object. 
    #
    # *data* argument can be specified as numeric arrays or num.cr tensors.
    # If *data* argument is not nil, data dimention will be checked against *index*
    # and *columns* arguments.
    def initialize(data=nil, @index=nil, @columns=nil)
      
      # If type of data is not a tensor, then make it a tensor.

      # Otherwise just make the argument equal to the local variable

    end

    ### Load methods ###
    def DataFrame.from_csv(path : String, delimiter = nil, header=false, index=false)
      raise "Method not implemented"
    end

    def DataFrame.from_json(path : String)
      raise "Method not implemented"
    end


    ### Save methods ###
    def to_csv
      raise "Method not implemented"
    end

    def to_json
      raise "Method not implemented"
    end

    ### Search methods ###
    def loc
      raise "Method not implemented"
    end

    def iloc
      raise "Method not implemented"
    end

    ### Transform methods ###

    def apply
      raise "Method not implemented"
    end

    def filter
      raise "Method not implemented"
    end

    def transpose
      raise "Method not implemented"
    end

    ### Math methods ###

    def corr
      raise "Method not implemented"
    end

    def cov
      raise "Method not implemented"
    end

    def max
      raise "Method not implemented"
    end

    def min
      raise "Method not implemented"
    end

    def mean
      raise "Method not implemented"
    end

    def median
      raise "Method not implemented"
    end

    def std
      raise "Method not implemented"
    end

    def var
      raise "Method not implemented"
    end

    def distance_matrix
      raise "Method not implemented"
    end
  end
end