% ==========================================
% KNOWLEDGE BASE (Facts)
% ==========================================
parent(john, mary).
parent(john, tom).
parent(susan, mary).
parent(susan, tom).
parent(bob, john).
parent(alice, susan).
parent(bob, david).
parent(david, anna).

% Helper predicate to check if a person is known in the system
person(X) :- parent(X, _).
person(X) :- parent(_, X).

% ==========================================
% LOGIC RULES
% ==========================================

% Find all parents of X (using findall to gather duplicates/multiple parents into a list)
get_parents(Person, Parents) :-
    findall(P, parent(P, Person), RawParents),
    sort(RawParents, Parents).  % remove duplicates if any

% Find all grandparents of X
get_grandparents(Person, Grandparents) :-
    findall(GP, (parent(Parent, Person), parent(GP, Parent)), RawGP),
    sort(RawGP, Grandparents).

% ==========================================
% MAIN INTERACTIVE PREDICATE
% ==========================================
check_relations :-
    write('Enter a name (in lowercase, followed by a dot .): '),
    read(Name),
    (   person(Name) ->
        format('~n--- Results for ~w ---~n', [Name]),
        
        % Parents
        get_parents(Name, Parents),
        (   Parents == [] ->
            writeln('Parents: None recorded')
        ;   format('Parents: ~w~n', [Parents])
        ),
        
        % Grandparents
        get_grandparents(Name, Grandparents),
        (   Grandparents == [] ->
            writeln('Grandparents: None recorded')
        ;   format('Grandparents: ~w~n', [Grandparents])
        )
    ;   format('~nError: The name "~w" is invalid or not found in the database.~n', [Name])
    ).