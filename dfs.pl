edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(d, goal).
edge(e, goal).
edge(f, goal).

connected(X, Y) :- edge(X, Y) ; edge(Y, X).

dfs_trace(Goal, Goal, Visited, Path) :-
    reverse([Goal | Visited], Path),
    format('Reached Goal via path: ~w~n', [Path]).

dfs_trace(Current, Goal, Visited, Path) :-
    connected(Current, Next),
    \+ member(Next, Visited),                    
    CurrentPath = [Current | Visited],
    reverse([Next | CurrentPath], DisplayPath),
    format('Exploring path branch: ~w~n', [DisplayPath]),
    dfs_trace(Next, Goal, [Current | Visited], Path).

solve_dfs(Start, Goal, Path) :-
    writeln('--- DFS Exploration Trace ---'),
    dfs_trace(Start, Goal, [], Path).