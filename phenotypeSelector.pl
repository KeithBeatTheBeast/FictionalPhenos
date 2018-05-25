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
% A predicate, childGenotype(+Father, +Mother, +Child) that takes in the parents and the child and produces a potential genotype  
% I want to make an external Python or Java script that will go through a Genotype file and check for inconsistencies/multiple predicates for allele interactions

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
phenotypePunnett(Gcar, GF1, GF2, GM1, GM2, UnsortedPhenos), sort(UnsortedPhenos, SetPhenos),
findPossiblePhenos(F, M, Gcdr, NextSetPhenos).

phenotypePunnett(Gene, GF1, GF2, GM1, GM2, [Pheno11, Pheno12, Pheno21, Pheno22]) :- 
determineDominant(Gene, GF1, GM1, Pheno11),
determineDominant(Gene, GF1, GM2, Pheno12),
determineDominant(Gene, GF2, GM1, Pheno21),
determineDominant(Gene, GF2, GM2, Pheno22).

printAllelesForGene([], _).
printAllelesForGene([Gcar|Gcdr], [Acar|Acdr]) :- format('~n~w: ', [Gcar]), printAllele(Acar), printAllelesForGene(Gcdr, Acdr).

printAllele([Allele|[]]) :- format('~w;', [Allele]).
printAllele([Car|Cdr]) :- format('~w, ', [Car]), printAllele(Cdr).

% child(+Father, +Mother, +Child); child(+Father, +Mother, +Child, -Genotype)
% Takes in three arguments correspondong to three sets of people predicates in the genotype database.
% And an additional, optional fourth argument corresponding to a list of genes (e.g. [eyes, hair])
% The default is the list of genes mentioned in the gene predicate of the database.
% For each gene, either by default or the custom list, the predicate will perform a punnett square operation
% on the parents alleles, producing a set of allele pairs.
% It then checks to see if the childs alleles for this gene are a member of that set.
% Reports possible/not possible on a gene-to-gene basis. Consider 1 "Not Possible" result as corresponding to 
% a complete fail, or false information.
child(Father, Mother, Child) :- genes(Genotype), format('~w + ~w = ~w?', [Father, Mother, Child]), child(Father, Mother, Child, Genotype).
child(_, _, _, []).
child(F, M, C, [Gcar|Gcdr]) :- fullPunnett(F, M, Gcar, AlleleSet), childMatchPrint(C, Gcar, AlleleSet), child(F, M, C, Gcdr), !.

fullPunnett(F, M, Gene, AlleleSet) :- person(F, Gene, GF1, GF2), person(M, Gene, GM1, GM2),
sort([[GF1, GM1], [GF1, GM2], [GF2, GM1], [GF2, GM2]], AlleleSet).

childMatchPrint(Child, Gene, ParentAlleleSet) :- person(Child, Gene, C1, C2), gMatch(C1, C2, ParentAlleleSet), 
format('~n~w: Possible', [Gene]).
childMatchPrint(_, Gene, _) :- format('~n~w: Not Possible', [Gene]).

gMatch(C1, C2, ParentAlleleSet) :- member([C1, C2], ParentAlleleSet); member([C2, C1], ParentAlleleSet).

% findRecessive(+Gene, +D_Allele, -R_Allele)
% Given a gene (eyes, hair) and a dominant allele for that gene, find all corresponding recessive alleles. 
% When the function simply returns true as the first result, it means the allele is dominant with respect
% to all other alleles for that gene in the database
% likewise, false means it is recessive to everything.
findRecessive(G, D, R) :- call(G, D, R, D), R \== D; call(G, R, D, D), R \== D.