% ==========================================
% MAZE REPRESENTATION (Facts)
% ==========================================
% Define connected nodes (bi-directional paths)
connected(a, b).
connected(a, c).
connected(b, d).
connected(c, e).
connected(d, f).
connected(e, f).
connected(e, g).
connected(f, goal).
connected(g, goal).

% ==========================================
% 1. DEPTH-FIRST SEARCH (DFS)
% ==========================================
% dfs(Current, Goal, VisitedPath, FinalPath)

dfs(Goal, Goal, Visited, Path) :-
    reverse([Goal | Visited], Path).

dfs(Current, Goal, Visited, Path) :-
    connected(Current, Next),
    \+ member(Next, Visited),                    % Prevent cycles
    dfs(Next, Goal, [Current | Visited], Path).

% Wrapper predicate for DFS
solve_dfs(Start, Goal, Path) :-
    dfs(Start, Goal, [], Path).


% ==========================================
% 2. BREADTH-FIRST SEARCH (BFS)
% ==========================================
% bfs(QueueOfPaths, Goal, FinalPath)
% Queue stores paths in reverse order for efficient extension

solve_bfs(Start, Goal, Path) :-
    breadth_first([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

% Base case: If the first path in the queue reaches the goal
breadth_first([[Goal | RestPath] | _], Goal, [Goal | RestPath]).

% Recursive step: Expand the queue
breadth_first([[Current | RestPath] | Queue], Goal, Path) :-
    findall([Next, Current | RestPath],
            (connected(Current, Next), \+ member(Next, [Current | RestPath])),
            NewPaths),
    append(Queue, NewPaths, UpdatedQueue),
    breadth_first(UpdatedQueue, Goal, Path).