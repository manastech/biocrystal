# Usage of Bio::Fasta functionalities.

require "../src/biocrystal"

myFasta = Bio::Fasta.from_file "data/6wwp.fasta"

puts myFasta.data.keys

myFasta.data.keys.each do |key|
  puts key
  puts myFasta.data[key].sequence
end