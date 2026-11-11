% ==========================================
% BREADTH-FIRST SEARCH WITH VISITED ORDER
% ==========================================

% Define graph edges (bi-directional undirected graph)
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(d, goal).
edge(e, goal).
edge(f, goal).

connected(X, Y) :- edge(X, Y) ; edge(Y, X).

% ==========================================
% BFS VISITATION TRAVERSE
% ==========================================
% solve_bfs_traversal(Start, Goal, VisitedOrder, ShortestPath)

solve_bfs_traversal(Start, Goal, VisitedOrder, Path) :-
    bfs_queue([[Start]], Goal, [], RevPath, RevVisited),
    reverse(RevPath, Path),
    reverse(RevVisited, VisitedOrder).

% Base case: Goal found
bfs_queue([[Goal | RestPath] | _], Goal, VisitedAcc, [Goal | RestPath], [Goal | VisitedAcc]).

% Recursive step: Expand queue and track visited nodes
bfs_queue([[Current | RestPath] | Queue], Goal, VisitedAcc, FinalPath, FinalVisited) :-
    (   \+ member(Current, VisitedAcc) ->
        NewVisitedAcc = [Current | VisitedAcc]
    ;   NewVisitedAcc = VisitedAcc
    ),
    findall([Next, Current | RestPath],
            (connected(Current, Next), \+ member(Next, [Current | RestPath])),
            NewPaths),
    append(Queue, NewPaths, UpdatedQueue),
    bfs_queue(UpdatedQueue, Goal, NewVisitedAcc, FinalPath, FinalVisited).