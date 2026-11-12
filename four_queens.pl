four_queens(Queens) :-
    Queens = [Q1, Q2, Q3, Q4],
    permutation([1, 2, 3, 4], Queens),
    safe(Queens).

safe([]).
safe([Q | Rest]) :-
    no_attack(Q, Rest, 1),
    safe(Rest).

no_attack(_, [], _).
no_attack(Q, [Q1 | Rest], Dist) :-
    Q =\= Q1 + Dist,           
    Q =\= Q1 - Dist,           
    Dist1 is Dist + 1,
    no_attack(Q, Rest, Dist1).