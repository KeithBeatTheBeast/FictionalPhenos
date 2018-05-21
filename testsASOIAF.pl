% testsASOIAF.pl
% May 19, 2018
% Author: Keith Mills

% Example test cases for the asoiafGenotype.pl file using the predicates defined in phenotypeSelector.pl

% Consult the data and the methods
:- consult(asoiafGenotype).
:- consult(phenotypeSelector).

% Tests for printPheno(+Name).

tests_pp1 :- printPheno(cersei).
tests_pp2 :- printPheno(jaime).
tests_pp3 :- printPheno(robert).
tests_pp4 :- printPheno(joffrey).
tests_pp5 :- printPheno(gendry).

% Tests for potentialPheno(+Father, +Mother).
tests_po1 :- potentialPhenos(robert, cersei).
tests_po2 :- potentialPhenos(jaime, cersei).