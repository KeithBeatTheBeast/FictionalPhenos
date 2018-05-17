% phenotypeSelector.pl
% May 16th, 2018
% Author: Keith Mills

% This is just a simple SWI Prolog program I decided to make in my free time to 
% Determine the possible phenotypes of offspring given a specified ruleset.
% It is mainly for fictional characters to see if a universe obeys simple genetics by punnett square logic.
% Does not have much code yet, just a few tests.
% To run this code and the current tests with SWI Prolog, you will need to consult 
% genotypeInformation.pl
% which contains the ruleset for dominant/recessive genes (can be arbitrary, whatever you desire)

% Assuming consult(genotypeInformation) has been invoked...
a1(N) :- eyes(brown, brown, N). % N = brown
a2(N) :- eyes(blue, brown, N). % N = brown, not working right now.
a3(N) :- eyes(brown, blue, N). % N = brown, does work.
a3 :- eyes(brown, brown, blue). % False

% TODO:
% A predicate, printPheno(+Name), that takes the name of an individual in the DB and reports their phenotypes
% A function, potentialPhenos(+Father, +Mother, -Eyes, -Hair), that takes the name of two individuals in the DB and lists all valid phenotype combinations.
% A function, possiblePhenos(+Father, +Mother, +Child) that takes three individuals in: father, mother and chiid, and reports if the child is possible