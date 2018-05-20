% asoiafGenotype.pl
% May 16th, 2018
% Author: Keith Mills

% Example ruleset for eyes and hair.
% Lets use George R. R. Martins ASOIAF!
% Book fans - please do not rip me to shreds over this.

% Most general rule: Anything is dominant with itself.
% After that, there is a color of eyes (baratheonBlue) and hair (baratheonBlack)
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
eyes(baratheonBlue, _, baratheonBlue). % Baratheon eyes dominant all cases,
eyes(green, blue, green). % Green dominates regular blue
eyes(blue, purple, blue). % Blue dominates purple
eyes(green, purple, purple). % Purple dominates green

eyes(X, X, X).
eyes(baratheonBlue, _, baratheonBlue). % Baratheon blue dominant all cases.
eyes(lannisterGreen, andalBlue, lannisterGreen).
eyes(andalBlue, valyrianViolet, valyrianViolet). % I recall a few Targs marrying blue-eyed Andals and the children having violet eyes.
eyes(lannisterGreen, valyrianViolet, lannisterGreen).

hair(X, X, X).
hair(baratheonBlack, _, baratheonBlack). % Baratheon hair dominates all
hair(firstMenBrown, lannisterGold, firstMenBrown). % Brown over blonde
hair(firstMenBrown, tullyRed, firstMenBrown). % Brown over red
hair(firstMenBrown, valyrianSilver, firstMenBrown). % Brown over silver
hair(lannisterGold, tullyRed, lannisterGold). % Blonde over red
hair(lannisterGold, valyrianSilver, valyrianSilver). % Silver over blonde
hair(tullyRed, valyrianSilver, tullyRed). % Red over silver

% The Mother of Madness
person(cersei, eyes, lannisterGreen, lannisterGreen).
person(cersei, hair, lannisterGold, lannisterGold).

% The Kingslayer
person(jaime, eyes, lannisterGreen, lannisterGreen).
person(jaime, hair, lannisterGold, lannisterGold).

% The Usurper King
person(robert, eyes, baratheonBlue, _).
person(robert, hair, baratheonBlack, firstMenBrown).

% Aerys III
person(joffrey, eyes, lannisterGreen, lannisterGreen).
person(joffrey, hair, lannisterGold, lannisterGold).

% Orys Baratheon reborn, or the One Trueborn Heir...?
person(gendry, eyes, baratheonBlue, _).
person(gendry, hair, baratheonBlack, _).