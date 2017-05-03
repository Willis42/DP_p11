% Definitions of items and locations

item(fox;goose;beans;boat).
location(left;right).

% Definition of the state at time t-1
h(F,t-1) :- tail(F).

% An action is executed between times t-1 and t
{move(I,L,t) : item(I), location(L), I!=boat} 1.
1 {move(boat,L,t) : location(L)} 1. 

% Effect of move(I,L)
h(on(I,L),t) :- move(I,L,t).

% That action is not executable
% if the boat and the item are not in the same starting location:
:- move(I,L,t), h(on(I,L1),t-1), h(on(boat,L2),t-1), L1!=L2.
% or if I is already at L:
:- move(I,L,t), h(on(I,L),t-1).
% or if the move would leave the fox and goose together without you:
:- h(on(fox,L),t), h(on(goose,L),t), not h(on(boat,L),t).
% or if the move would leave the goose and the beans together:
:- h(on(goose,L),t), h(on(beans,L),t).

% Existence and uniqueness of location
:- #count{L : h(on(I,L),t)} != 1, item(I).

% inertia
{h(F,t)} :- h(F,t-1).

#show move/3.
#show h/2.
