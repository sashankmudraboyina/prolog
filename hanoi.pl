% ==========================================
% TOWER OF HANOI
% ==========================================
% hanoi(N, Source, Destination, Auxiliary)
% N: Number of disks
% Source: Starting rod
% Destination: Target rod
% Auxiliary: Temporary helper rod

% Base case: If there is 1 disk, move it directly from Source to Destination
hanoi(1, Source, Destination, _) :-
    format('Move disk 1 from ~w to ~w~n', [Source, Destination]).

% Recursive step:
hanoi(N, Source, Destination, Auxiliary) :-
    N > 1,
    N1 is N - 1,
    % Step 1: Move top N-1 disks from Source to Auxiliary
    hanoi(N1, Source, Auxiliary, Destination),
    % Step 2: Move the remaining largest disk from Source to Destination
    format('Move disk ~w from ~w to ~w~n', [N, Source, Destination]),
    % Step 3: Move the N-1 disks from Auxiliary to Destination
    hanoi(N1, Auxiliary, Destination, Source).