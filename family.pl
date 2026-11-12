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
parent(charles, diana).


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


father(F, C) :- 
    parent(F, C), 
    male(F).

mother(M, C) :- 
    parent(M, C), 
    female(M).

grandparent(GP, GC) :- 
    parent(GP, P), 
    parent(P, GC).

person(X) :- parent(X, _).
person(X) :- parent(_, X).

lookup_parents(Person, ParentsList) :-
    (   person(Person) ->
        findall(P, parent(P, Person), RawList),
        sort(RawList, ParentsList)
    ;   format('~w is not found in the database.~n', [Person]),
        ParentsList = []
    ).

lookup_grandparents(Person, GpsList) :-
    (   person(Person) ->
        findall(GP, grandparent(GP, Person), RawList),
        sort(RawList, GpsList)
    ;   format('~w is not found in the database.~n', [Person]),
        GpsList = []
    ).

lookup_all_ancestors(Person, AncestorsList) :-
    (   person(Person) ->
        setof(A, r_ancestor(Person, A), AncestorsList)
    ;   format('~w is not found in the database.~n', [Person]),
        AncestorsList = []
    ).
r_ancestor(X, A) :- parent(A, X). 
r_ancestor(X, A) :- parent(P, X), r_ancestor(P, A).