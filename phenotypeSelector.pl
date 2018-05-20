% phenotypeSelector.pl
% May 16th, 2018
% Author: Keith Mills

% This is just a simple SWI Prolog program I decided to make in my free time to 
% determine the possible phenotypes of offspring given a specified ruleset.
% This is not meant to be used on real-life genetics I am sure real-life genetics are more complicated than that.
% Rather, its loosely based on testing the concept of "Magic A Is Magic A"
% http://tvtropes.org/pmwiki/pmwiki.php/Main/MagicAIsMagicA
% but applied to the genetics of a universe.

% It is mainly for fictional characters to see if their made-up universe obeys simple genetics by punnett square logic.
% To run this code and the current tests with SWI Prolog, you will need to consult 
% a sample genotype file (ruleset), containing a list of relevant genes, dominant/recessive rules, 
% and individuals with their traits.
% A sample genotype file is provided, asoiafGenotype.pl, alongside test cases in testsASOIAF.pl

% TODO:
% A function, potentialPhenos(+Father, +Mother, -Eyes, -Hair), that takes the name of two individuals in the DB and lists all valid phenotype combinations.
% A function, possiblePhenos(+Father, +Mother, +Child) that takes three individuals in: father, mother and chiid, and reports if the child is possible

% printPheno(+Name).
% Takes in the name of the individual as an argument.
% It then recursively goes through the list of genes declared in 
% the genes predicate of the genotype file you are consulting.
% For each gene, it will find the dominant allele, and list it.
% If no information for said individual on that gene is found, a message is returned stating as such.
printPheno(Name) :- genes(Genotype), format('~w:', [Name]), printPheno(Name, Genotype), !.
printPheno(_, []).
printPheno(Name, [Gcar|Gcdr]) :- dominantGene(Gcar, Name, Pheno), !, format('~n~w of ~w', [Pheno, Gcar]), printPheno(Name, Gcdr).
printPheno(Name, [Gcar|Gcdr]) :- format('~nmissing ~w information', [Gcar]), printPheno(Name, Gcdr).

dominantGene(Gene, Name, Pheno) :- person(Name, Gene, G1, G2), determineDominant(Gene, G1, G2, Pheno).
determineDominant(Gene, G1, G2, Pheno) :- call(Gene, G1, G2, Pheno); call(Gene, G2, G1, Pheno).