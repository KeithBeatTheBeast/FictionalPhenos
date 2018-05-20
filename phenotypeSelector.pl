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

% potentialPhenos(+Father, +Mother).
potentialPhenos(Father, Mother) :- genes(Genotype),
findPossiblePhenos(Father, Mother, Genotype, GeneAlleleList),
cartesianProduct(GeneAlleleList, [AlleleSets]),
printAlleles(Genotype, AlleleSets), !.

findPossiblePhenos(_, _, [], []).
findPossiblePhenos(F, M, [Gcar|Gcdr], [SetPhenos|NextSetPhenos]) :- 
person(F, Gcar, GF1, GF2), 
person(M, Gcar, GM1, GM2), 
printPunnett(Gcar, GF1, GF2, GM1, GM2, UnsortedPhenos), sort(UnsortedPhenos, SetPhenos),
findPossiblePhenos(F, M, Gcdr, NextSetPhenos).

printPunnett(Gene, GF1, GF2, GM1, GM2, [Pheno11, Pheno12, Pheno21, Pheno22]) :- 
determineDominant(Gene, GF1, GM1, Pheno11),
determineDominant(Gene, GF1, GM2, Pheno12),
determineDominant(Gene, GF2, GM1, Pheno21),
determineDominant(Gene, GF2, GM2, Pheno22).

cartesianProduct([], []).
cartesianProduct([GALcar, GALcaar|GALcdr], [AScar|AScdr]) :- product(GALcar, GALcaar, AScar), cartesianProduct(GALcdr, AScdr).

% https://gist.github.com/raskasa/4282471
% Edited to remove singletons.
% product(+xs,+Ys,-Zs)
%  returns in the Cartesian product of sets Xs and Ys in Zs.
product([],_,[]).
product([A|As],Bs,Cs) :- pairs(A,Bs,Xs), product(As,Bs,Ys), append(Xs,Ys,Cs).

% pairs(+X,+Xs,-Ys)
%  returns in Ys the list of pairs
pairs(_,[],[]).
pairs(A,[B|Bs],[[A,B]|Cs]) :- pairs(A,Bs,Cs).

% append(+As,+Bs,-Cs)
%  returns in Cs the append of lists As and Bs
append([],Bs,Bs).
append([A|As],Bs,[A|Cs]) :- append(As,Bs,Cs).

printAlleles(_, []).
printAlleles(Genes, [AScar|AScdr]) :- printSet(Genes, AScar), format('~n', []), printAlleles(Genes, AScdr).

printSet(_, []).
printSet([Gcar|Gcdr], [Acar|Acdr]) :- format('~w of ~w, ', [Acar, Gcar]), printSet(Gcdr, Acdr).