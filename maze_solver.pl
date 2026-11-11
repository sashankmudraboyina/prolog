% ==========================================
% MAZE REPRESENTATION (Facts)
% ==========================================
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, e).
edge(d, f).
edge(e, f).
edge(e, g).
edge(f, goal).
edge(g, goal).

connected(X, Y) :- edge(X, Y) ; edge(Y, X).

% ==========================================
% 1. BREADTH-FIRST SEARCH (BFS)
% ==========================================
solve_bfs(Start, Goal, Path) :-
    breadth_first([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

breadth_first([[Goal | RestPath] | _], Goal, [Goal | RestPath]).

breadth_first([[Current | RestPath] | Queue], Goal, Path) :-
    findall([Next, Current | RestPath],
            (connected(Current, Next), \+ member(Next, [Current | RestPath])),
            NewPaths),
    append(Queue, NewPaths, UpdatedQueue),
    breadth_first(UpdatedQueue, Goal, Path).


% ==========================================
% 2. DEPTH-FIRST SEARCH (DFS)
% ==========================================
dfs_trace(Goal, Goal, Visited, Path) :-
    reverse([Goal | Visited], Path).

dfs_trace(Current, Goal, Visited, Path) :-
    connected(Current, Next),
    \+ member(Next, Visited),
    dfs_trace(Next, Goal, [Current | Visited], Path).

solve_dfs(Start, Goal, Path) :-
    dfs_trace(Start, Goal, [], Path).


% ==========================================
% 3. MAIN COMPARISON PREDICATE
% ==========================================
compare_maze(Start, Goal) :-
    writeln('========================================='),
    writeln('          MAZE SOLVER COMPARISON         '),
    writeln('========================================='),
    
    % Run BFS
    format('~n[1] Running Breadth-First Search (BFS)...~n'),
    (   solve_bfs(Start, Goal, BfsPath) ->
        format('BFS Optimal Path found: ~w~n', [BfsPath])
    ;   writeln('BFS: No path found.')
    ),

    % Run DFS
    format('~n[2] Running Depth-First Search (DFS)...~n'),
    (   solve_dfs(Start, Goal, DfsPath) ->
        format('DFS Solution Path found: ~w~n', [DfsPath])
    ;   writeln('DFS: No path found.')
    ),

    % Evaluation Summary
    writeln('~n-----------------------------------------'),
    writeln('           EFFICIENCY COMPARISON         '),
    writeln('-----------------------------------------'),
    writeln('* Optimality: BFS guarantees the SHORTEST/OPTIMAL path.'),
    writeln('  DFS finds a valid path, but it may be non-optimal (winding or longer).'),
    writeln('* Memory / Space: DFS uses less memory (linear with depth)'),
    writeln('  whereas BFS can consume high memory keeping wide frontiers.'),
    writeln('=========================================').