% genotypeInformation.pl
% May 16th, 2018
% Author: Keith Mills
% Example ruleset for eyes and hair.

% Most general rule: Anything is dominant with itself.
% After that, there is a color of eyes (brown) and hair (black)
% that is dominant over all else.
% Then the individual rules amongst the other recessive genes e.g. blue vs green eyes.

% Predicates take the form of
% feature(+A, +B, -C).
% Where feature is eyes or hair (currently)
% A and B are the genes
% C is what is represented in the phenotype

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