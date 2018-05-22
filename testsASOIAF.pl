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
tests_po3 :- potentialPhenos(gendry, arya). % https://youtu.be/63lE2ns_vUY?t=3m4s
tests_po4 :- potentialPhenos(joffrey, sansa).
tests_po5 :- potentialPhenos(joffrey, daenerys). % You thought Aerys II was mad? Have not seen anything yet!

% Tests for child(+Father, +Mother, +Child).
tests_c01 :- child(robert, cersei, joffrey).
tests_c02 :- child(jaime, cersei, joffrey).
tests_c03 :- child(robert, cersei, gendry).

% Tests for findRecessive(+Gene, +D_Allele, -R_Allele)
tests_r01(R) :- findRecessive(eyes, valyrianViolet, R).
tests_r02(R) :- findRecessive(eyes, baratheonBlue, R).
tests_r03(R) :- findRecessive(hair, valyrianSilver, R).
tests_r04(R) :- findRecessive(hair, lannisterGold, R).
tests_r05(R) :- findRecessive(dragonBlood, westerosi, R).
tests_r06(R) :- findRecessive(dragonBlood, valyrian, R).