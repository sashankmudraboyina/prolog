hanoi(1, Source, Destination, _) :-
    format('Move disk 1 from ~w to ~w~n', [Source, Destination]).

hanoi(N, Source, Destination, Auxiliary) :-
    N > 1,
    N1 is N - 1,
    hanoi(N1, Source, Auxiliary, Destination),
    format('Move disk ~w from ~w to ~w~n', [N, Source, Destination]),
    hanoi(N1, Auxiliary, Destination, Source).