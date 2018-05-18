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
% A function, potentialPhenos(+Father, +Mother, -Eyes, -Hair), that takes the name of two individuals in the DB and lists all valid phenotype combinations.
% A function, possiblePhenos(+Father, +Mother, +Child) that takes three individuals in: father, mother and chiid, and reports if the child is possible

% printPheno(+Name).
% Takes in the name of the individual as an argument, and reports 
printPheno(Name) :- getDominantEyes(Name, Eyes), getDominantHair(Name, Hair), statePheno(Name, Eyes, Hair).

getDominantEyes(N, E) :- person(N, eyes, E1, E2), domEye(E1, E2, E), !.
domEye(E1, E2, E) :- eyes(E1, E2, E).
domEye(E1, E2, E) :- eyes(E2, E1, E).

getDominantHair(N, H) :- person(N, hair, H1, H2), domHair(H1, H2, H), !.
domHair(H1, H2, H) :- hair(H1, H2, H).
domHair(H1, H2, H) :- hair(H2, H1, H).

statePheno(N, E, H) :- format('~w is ~w of hair, ~w of eye', [N, H, E]).

% test(E, X1, X2, X) :- call(E, [X1, X2], X).