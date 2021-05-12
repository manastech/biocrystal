require "./sequence"

module Bio
  class Fasta < SequenceDB
    def initialize(@str : String, @id_field = 0)
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

    def Fasta.from_file(path, id_field = 0)
      Fasta.new(File.read(path), id_field)
    end
  end
end