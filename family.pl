% ==========================================
% KNOWLEDGE BASE (Facts & Rules)
% ==========================================

% Parent facts
parent(john, mary).
parent(john, tom).
parent(john, sita).
parent(susan, mary).
parent(susan, tom).
parent(susan, sita).
parent(bob, john).
parent(alice, susan).
parent(bob, david).
parent(david, anna).
parent(charles, diana). % Extra data for testing

% Gender facts
male(john).
male(tom).
male(bob).
male(david).
male(charles).

female(susan).
female(mary).
female(sita).
female(alice).
female(anna).
female(diana).

% ==========================================
% LOGIC RULES
% ==========================================

% Standard binary rules for checking relationships directly
father(F, C) :- 
    parent(F, C), 
    male(F).

mother(M, C) :- 
    parent(M, C), 
    female(M).

grandparent(GP, GC) :- 
    parent(GP, P), 
    parent(P, GC).

% Helper to check if a person exists in the database
person(X) :- parent(X, _).
person(X) :- parent(_, X).

% ==========================================
% LIST LOOKUP FEATURES (New)
% ==========================================

% 1. Lookup all parents of a Person and return them in a List.
% Usage: ?- lookup_parents(mary, ParentsList).
lookup_parents(Person, ParentsList) :-
    (   person(Person) ->
        findall(P, parent(P, Person), RawList),
        sort(RawList, ParentsList) % sort/1 removes duplicates
    ;   format('~w is not found in the database.~n', [Person]),
        ParentsList = []
    ).

% 2. Lookup all grandparents of a Person and return them in a List.
% Usage: ?- lookup_grandparents(tom, GpsList).
lookup_grandparents(Person, GpsList) :-
    (   person(Person) ->
        findall(GP, grandparent(GP, Person), RawList),
        sort(RawList, GpsList)
    ;   format('~w is not found in the database.~n', [Person]),
        GpsList = []
    ).

% 3. Lookup ALL ancestors (parents, grandparents, etc.) in a sorted list.
% Uses recursion (transitive closure) to find parents of parents.
% Usage: ?- lookup_all_ancestors(anna, AncestorsList).
lookup_all_ancestors(Person, AncestorsList) :-
    (   person(Person) ->
        setof(A, r_ancestor(Person, A), AncestorsList)
    ;   format('~w is not found in the database.~n', [Person]),
        AncestorsList = []
    ).

% Recursive helper for all ancestors
r_ancestor(X, A) :- parent(A, X). % A is parent of X
r_ancestor(X, A) :- parent(P, X), r_ancestor(P, A). % A is ancestor of P