start_state(state(0, 0)).

is_goal(state(2, _)).

pour(state(_, J2), state(4, J2)).

pour(state(J1, _), state(J1, 3)).

pour(state(_, J2), state(0, J2)).

pour(state(J1, _), state(J1, 0)).

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

solve_jug(Path) :-
    start_state(Start),
    solve_path(Start, [Start], RevPath),
    reverse(RevPath, Path).

solve_path(Current, _, [Current]) :-
    is_goal(Current).

solve_path(Current, Visited, [Current | Path]) :-
    pour(Current, Next),
    \+ member(Next, Visited),             
    solve_path(Next, [Next | Visited], Path).