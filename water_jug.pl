% ==========================================
% WATER JUG PROBLEM SOLVER (BFS / DFS)
% ==========================================
% State representation: state(Jug1, Jug2)
% Jug1 capacity = 4 gallons
% Jug2 capacity = 3 gallons
% Goal: state(2, _) -> 2 gallons in Jug1

% Initial state
start_state(state(0, 0)).

% Goal state
is_goal(state(2, _)).

% ==========================================
% VALID ACTIONS (Transitions)
% ==========================================

% 1. Fill Jug 1 to full capacity (4 gallons)
pour(state(_, J2), state(4, J2)).

% 2. Fill Jug 2 to full capacity (3 gallons)
pour(state(J1, _), state(J1, 3)).

% 3. Empty Jug 1 completely
pour(state(_, J2), state(0, J2)).

% 4. Empty Jug 2 completely
pour(state(J1, _), state(J1, 0)).

% 5. Pour water from Jug 1 into Jug 2 until Jug 2 is full or Jug 1 is empty
pour(state(J1, J2), state(NewJ1, NewJ2)) :-
    J2 < 3,
    J1 > 0,
    Space is 3 - J2,
    (   J1 >= Space ->
        NewJ2 is 3,
        NewJ1 is J1 - Space
    ;   
        NewJ2 is J2 + J1,
        NewJ1 is 0
    ).

% 6. Pour water from Jug 2 into Jug 1 until Jug 1 is full or Jug 2 is empty
pour(state(J1, J2), state(NewJ1, NewJ2)) :-
    J1 < 4,
    J2 > 0,
    Space is 4 - J1,
    (   J2 >= Space ->
        NewJ1 is 4,
        NewJ2 is J2 - Space
    ;   
        NewJ1 is J1 + J2,
        NewJ2 is 0
    ).

% ==========================================
% PATH FINDING (Depth-First / Backtracking Search)
% ==========================================
solve_jug(Path) :-
    start_state(Start),
    solve_path(Start, [Start], RevPath),
    reverse(RevPath, Path).

solve_path(Current, _, [Current]) :-
    is_goal(Current).

solve_path(Current, Visited, [Current | Path]) :-
    pour(Current, Next),
    \+ member(Next, Visited),             % Prevent cycles
    solve_path(Next, [Next | Visited], Path).