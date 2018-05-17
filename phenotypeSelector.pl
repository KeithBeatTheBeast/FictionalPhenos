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