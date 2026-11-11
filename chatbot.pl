% ==========================================
% RULE-BASED CHATBOT (Interactive Loop)
% ==========================================

% Start predicate to kick off the conversation
start_chat :-
    writeln('Chatbot: Hello! Ask me something or type bye to exit.'),
    chat_loop.

% Base case: if user inputs 'bye' or "bye", terminate the loop
chat_loop :-
    write('You: '),
    read(Input),
    (   Input == bye ->
        writeln('Chatbot: Goodbye! Have a great day.')
    ;   % Otherwise, respond and loop again
        respond(Input, Reply),
        format('Chatbot: ~w~n', [Reply]),
        chat_loop
    ).

% Predefined rules for responses
respond(hello, 'Hi there! How can I help you today?').
respond(hi, 'Hello! Nice to meet you.').
respond(how are you, 'I am just a computer program, but I am doing great!').
respond(what is your name, 'I am your AI Essentials Prolog Chatbot.').

% Fallback rule for unknown inputs
respond(_, 'I am sorry, I do not understand that query. Please try asking something else.').