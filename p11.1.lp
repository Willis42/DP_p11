% Definitions of items and locations

item(a;b;c;boat).
location(left;right).

% Definition of the state at time t-1
h(F,t-1) :- tail(F).

% An action is executed between times t-1 and t
{move(I,L,t) : item(I), location(L), I!=boat} 1.
1 {move(boat,L,t) : location(L)} 1.
% achieved: the boat and possibly 1 item move from one island to the other

% Effect of move(I,L)
h(on(I,L),t) :- move(I,L,t).

% That action is not executable
% if the boat is already on the island you're moving to (therefore not on the same island you're moving from):
:- move(I,L,t), h(on(boat,L),t-1).
% or if I is already at L:
:- move(I,L,t), h(on(I,L),t-1).
% or if the item is not moving with the boat:
%:- move(I,L1,t), move(boat,L2,t), I!=boat, L1!=L2.

% Existence and uniqueness of location
:- #count{L : h(on(I,L),t)} != 1, item(I).

% inertia
{h(F,t)} :- h(F,t-1).

#show move/3.
#show h/2.

