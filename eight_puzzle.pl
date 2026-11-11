% ==========================================
% 8-PUZZLE SOLVER FOR ANY JUMBLED INPUT (BFS)
% ==========================================
% State representation: A list of 9 numbers (0 through 8).
% Goal State: [1, 2, 3, 4, 5, 6, 7, 8, 0]

goal([1, 2, 3, 4, 5, 6, 7, 8, 0]).

% Adjacency map of indices on a 3x3 grid (0 to 8)
% 0 1 2
% 3 4 5
% 6 7 8
valid_move(0, 1). valid_move(1, 0).
valid_move(0, 3). valid_move(3, 0).
valid_move(1, 2). valid_move(2, 1).
valid_move(1, 4). valid_move(4, 1).
valid_move(2, 5). valid_move(5, 2).
valid_move(3, 4). valid_move(4, 3).
valid_move(3, 6). valid_move(6, 3).
valid_move(4, 5). valid_move(5, 4).
valid_move(4, 7). valid_move(7, 4).
valid_move(5, 8). valid_move(8, 5).
valid_move(6, 7). valid_move(7, 6).
valid_move(7, 8). valid_move(8, 7).

% Helper to swap elements and generate a new state
swap(List, I1, I2, Res) :-
    nth0(I1, List, E1),
    nth0(I2, List, E2),
    replace(List, I1, E2, Temp),
    replace(Temp, I2, E1, Res).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

% Move the blank tile (0) to generate successor states
move(State, NextState) :-
    nth0(ZIndex, State, 0),
    valid_move(ZIndex, TargetIndex),
    swap(State, ZIndex, TargetIndex, NextState).

% ==========================================
% BREADTH-FIRST SEARCH ALGORITHM
% ==========================================
solve(Start, Path) :-
    breadth_first([[Start]], RevPath),
    reverse(RevPath, Path).

breadth_first([[Goal | Rest] | _], [Goal | Rest]) :-
    goal(Goal).

breadth_first([[Current | Rest] | Queue], Path) :-
    findall([Next, Current | Rest],
            (move(Current, Next), \+ member(Next, [Current | Rest])),
            NewPaths),
    append(Queue, NewPaths, UpdatedQueue),
    breadth_first(UpdatedQueue, Path).