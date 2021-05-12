require "./sequence"

module Bio

  # Fasta
  # 
  # A class `SequenceDB` created from a fasta file.
  #
  # The descriptors of each sequence will be based on the fields
  # separated by '|' as defined in the format. Descriptor names can
  # be provided optionally for further filtering. 
  class Fasta < SequenceDB

    # Creates a new Fasta object from a fasta-formatted String.
    # *id_field* is the univocal identificator of the sequence within the database.
    # *descriptor_names* can be optionally provided for the fields within the sequence header.
    def initialize(@str : String, @id_field = 0, @descriptor_names = nil)
      # Can I call super or something?
      @data = Hash(String, Sequence).new

      last_key = Nil
      @str.each_line do |line|
        if line.char_at(0) == '>'
          l = line[1...]
          @data[ l.split("|")[@id_field] ] = Sequence.new( l.split("|") , "")
          
          last_key = l.split("|")[@id_field]
        else
          @data[last_key].sequence += line.strip
        end
      end
    end

    # Creates a new Fasta object from a local file.
    def Fasta.from_file(path, id_field = 0, descriptor_names = nil)
      Fasta.new(File.read(path), id_field, descriptor_names)
    end

    # TODO: Creates a new Fasta object from a remote file.
    # def Fasta.from_url
    # end
  end
end