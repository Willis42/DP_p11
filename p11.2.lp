% Definitions of items and locations

item(fox;goose;beans;boat).
location(left;right).

% Definition of the state at time t-1
h(F,t-1) :- tail(F).

% An action is executed between times t-1 and t
{move(I,L,t) : item(I), location(L), I!=boat} 1.
1 {move(boat,L,t) : location(L)} 1.
% achieved: the boat and possibly 1 item move from one side to the other

% Effect of move(I,L)
h(on(I,L),t) :- move(I,L,t).

% That action is not executable
% if the boat is already on the side you're moving to (therefore not on the same side you're moving from):
:- move(I,L,t), h(on(boat,L),t-1).
% or if I is already at L:
:- move(I,L,t), h(on(I,L),t-1).
% or if the move would leave the fox and goose together unattended:
:- h(on(fox,L),t), h(on(goose,L),t), not h(on(boat,L),t).
% or if the move would leave the goose and the beans together unattended:
:- h(on(goose,L),t), h(on(beans,L),t), not h(on(boat,L),t).

% Existence and uniqueness of location
:- #count{L : h(on(I,L),t)} != 1, item(I).

% inertia
{h(F,t)} :- h(F,t-1).

#show move/3.
#show h/2.

