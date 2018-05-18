% asoiafGenotype.pl
% May 16th, 2018
% Author: Keith Mills
% Example ruleset for eyes and hair.
% Lets use George R. R. Martins ASOIAF!

% Most general rule: Anything is dominant with itself.
% After that, there is a color of eyes (brown) and hair (black)
% that is dominant over all else.
% Then the individual rules amongst the other recessive genes e.g. blue vs green eyes.

% Predicates take the form of
% gene(+G1, +G2, -Pheno).
% Where gene is a feature like eyes or hair the program is scalable - not limited to eyes and hair.
% For new genes, add in the appropriate predicates for dominant/recessive interactions
% and then place the name of the gene in the list in the genes predicate.
% +G1 and +G2 are the alleles, -Pheno is one of G1 or G2, whichever is dominant.

% People predicates take the form of
% person(Name, Gene, G1, G2).
% Name is name, Gene is the gene referenced for that person.
% G1 and G2 are their alleles

genes([eyes, hair]).

eyes(X, X, X).
eyes(brown, _, brown). % Brown eyes dominant all cases,
eyes(green, blue, green). % Green dominates blue
eyes(blue, purple, blue). % Blue dominates purple
eyes(green, purple, purple). % Purple dominates green


hair(X, X, X).
hair(black, _, black). % Black dominates all
hair(brown, blonde, brown). % Brown over blonde
hair(brown, red, brown). % Brown over red
hair(brown, silver, brown). % Brown over silver
hair(blonde, red, blonde). % Blonde over red
hair(blonde, silver, silver). % Silver over blonde
hair(red, silver, red). % Red over silver

% The Mother of Madness
person(cersei, eyes, green, blue).
person(cersei, hair, blonde, blonde).

% The Kingslayer
person(jaime, eyes, green, green).
person(jaime, hair, blonde, blonde).

% The Usurper King
person(robert, eyes, blue, purple).
person(robert, hair, black, brown).

% Aerys III
person(joffrey, eyes, green, green).
person(joffrey, hair, blonde, blonde).

% Orys Baratheon reborn, or the One Trueborn Heir...?
person(gendry, eyes, blue, blue).
person(gendry, hair, black, blonde).