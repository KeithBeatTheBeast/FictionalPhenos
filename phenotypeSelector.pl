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

% potentialPhenos(+Father, +Mother); potentialPhenos(+Father, +Mother, +Genotype).
% Given two individuals, execute punnett squares for every gene avaliable in the set.
% Then print out, for each gene, the phenotypes possible.
% I chose to do it like this rather than to list out every possible combination
% since that requires use of a cartesian product and the data output grows too quickly.
% Use the two-arg predicate to calculate for all genes in the genes predicate, three argument to specify a custom sublist of genes.
potentialPhenos(Father, Mother) :- genes(Genotype), potentialPhenos(Father, Mother, Genotype).
potentialPhenos(Father, Mother, Genotype) :- findPossiblePhenos(Father, Mother, Genotype, GeneAlleleList),
format('~w x ~w produces an offspring whose phenotype is a combination of the following lists:', [Father, Mother]), 
printAllelesForGene(Genotype, GeneAlleleList), !.

findPossiblePhenos(_, _, [], []).
findPossiblePhenos(F, M, [Gcar|Gcdr], [SetPhenos|NextSetPhenos]) :- 
person(F, Gcar, GF1, GF2), 
person(M, Gcar, GM1, GM2), 
fullPunnett(Gcar, GF1, GF2, GM1, GM2, UnsortedPhenos), sort(UnsortedPhenos, SetPhenos),
findPossiblePhenos(F, M, Gcdr, NextSetPhenos).

fullPunnett(Gene, GF1, GF2, GM1, GM2, [Pheno11, Pheno12, Pheno21, Pheno22]) :- 
determineDominant(Gene, GF1, GM1, Pheno11),
determineDominant(Gene, GF1, GM2, Pheno12),
determineDominant(Gene, GF2, GM1, Pheno21),
determineDominant(Gene, GF2, GM2, Pheno22).

printAllelesForGene([], _).
printAllelesForGene([Gcar|Gcdr], [Acar|Acdr]) :- format('~n~w: ', [Gcar]), printAllele(Acar), printAllelesForGene(Gcdr, Acdr).

printAllele([Allele|[]]) :- format('~w;', [Allele]).
printAllele([Car|Cdr]) :- format('~w, ', [Car]), printAllele(Cdr).

