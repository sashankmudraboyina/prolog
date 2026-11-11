% ==========================================
% 4-QUEENS PROBLEM
% ==========================================
% Representation: A list [Q1, Q2, Q3, Q4] where the index represents 
% the column (1 to 4) and the value represents the row (1 to 4).

four_queens(Queens) :-
    Queens = [Q1, Q2, Q3, Q4],
    permutation([1, 2, 3, 4], Queens),
    safe(Queens).

% Check if all queens are safe from diagonal attacks
safe([]).
safe([Q | Rest]) :-
    no_attack(Q, Rest, 1),
    safe(Rest).

% Ensure no two queens lie on the same diagonal
no_attack(_, [], _).
no_attack(Q, [Q1 | Rest], Dist) :-
    Q =\= Q1 + Dist,           % Check positive diagonal
    Q =\= Q1 - Dist,           % Check negative diagonal
    Dist1 is Dist + 1,
    no_attack(Q, Rest, Dist1).