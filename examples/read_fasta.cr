# Demonstration of Bio::Fasta functionalities.

require "../src/biocrystal"

# TODO: Create a fasta collection of sequence from a string


# Create a fasta collection of sequences from a local file 
myFasta = Bio::Fasta.from_file( "data/6wwp.fasta" , 0, nil, sequence_type = Bio::SequenceType::Protein )

# Print the list of the sequences' ids stored in myFasta object
puts myFasta.data.keys

# Print the ids and sequences stored in myFasta object
myFasta.records.each do |key|
  puts key
  puts myFasta.record(key).sequence
end

# TODO: Search all sequences from the organism Sus scrofa (9823)

# TODO: Create a fasta collection of sequence from a remote url


# TODO: Blast a sequence locally with blast

puts
puts myFasta.to_fasta_str
puts

blast_results = Bio::Blast.run_local( myFasta, myFasta.record(myFasta.records[0]) )

blast_results.each do | hit |
  puts "There is a hit on #{hit.accession}!"
  hit.hsps.each do | hsp |
    puts "  High scoring pairs matched:"
    puts "    ->    query: "+hsp.qseq
    puts "    ->  midline: "+hsp.midline
    puts "    ->      hit: "+hsp.hseq
    puts 
  end
end