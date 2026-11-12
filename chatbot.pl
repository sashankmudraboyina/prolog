start_chat :-
    writeln('Chatbot: Hello! Ask me something or type bye to exit.'),
    chat_loop.

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

respond(hello, 'Hi there! How can I help you today?').
respond(hi, 'Hello! Nice to meet you.').
respond(how are you, 'I am just a computer program, but I am doing great!').
respond(what is your name, 'I am your AI Essentials Prolog Chatbot.').

respond(_, 'I am sorry, I do not understand that query. Please try asking something else.').

% use start_chat. to initiate the chatbot interaction.