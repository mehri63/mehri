# Example using the Chemistry Development Kit to generate a molecular fingerprint of two chemicals
# we then compare those chemicals using their tanimoto score.
# author :: Dana Klassen
# credit :: credit goes to http://depth-first.com/articles/2006/11/22/scripting-molecular-fingerprints-with-ruby-cdk/

# example generating a molecular finger print from an input SMILES string
ENV['CLASSPATH'] = File.join(File.expand_path(File.dirname(__FILE__)),"/jar/cdk-1.4.16.jar")
require 'rubygems'
require 'rjb'

# all the java classes we need brought into ruby
SmilesParser      = Rjb::import 'org.openscience.cdk.smiles.SmilesParser'
FingerPrinter     = Rjb::import 'org.openscience.cdk.fingerprint.Fingerprinter'
DefaultChemObject = Rjb::import 'org.openscience.cdk.DefaultChemObjectBuilder'
Tanimoto          = Rjb::import 'org.openscience.cdk.similarity.Tanimoto'

# The two input chemicals 
chemical1     = "CCCC1=NN(C)C2=C1NC(=NC2=O)C1=C(OCC)C=CC(=C1)S(=O)(=O)N1CCN(C)CC1"
chemical2     = "CN1CC(=O)N2[C@H](CC3=C(NC4=CC=CC=C34)[C@H]2C2=CC3=C(OCO3)C=C2)C1=O"

# The two input molecules convereted to IAtomContainers
molecule1     = SmilesParser.new(DefaultChemObject.getInstance()).parseSmiles(chemical1)
molecule2     = SmilesParser.new(DefaultChemObject.getInstance()).parseSmiles(chemical2)

# Generate the finger prints for each molecule
fingerprinter = FingerPrinter.new
fingerprint1  = fingerprinter.getFingerprint molecule1
fingerprint2  = fingerprinter.getFingerprint molecule2

puts "size of fingerprints 1 and 1:"
puts "  #{fingerprint1.size}"
puts "	#{fingerprint2.size}"

puts "cardinality of fingerprints:"
puts "	#{fingerprint1.cardinality}"
puts "	#{fingerprint2.cardinality}"

puts "which bits are set to true:"
puts "	#{fingerprint1.toString}"
puts "	#{fingerprint2.toString}"

# the Tanimoto similarity of the two compounds
puts "Similarity between both compoudns:"
puts Tanimoto.calculate(fingerprint1,fingerprint2)
