% Name Game

:- dynamic letters/1.

% Initial set of letters
letters([a, b, c]).

% Start the game
start_game :-
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters.'), nl,
    write('You can add, delete or move letters to create your name.'), nl,
    menu.

% Display the menu
menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    handle_choice(Choice).

% Display current letters
handle_choice(1) :-
    letters(Current),
    write('Current set of letters: '),
    write(Current), nl,
    menu.

% Add a letter
handle_choice(2) :-
    write('Enter a letter: '),
    read(Letter),
    letters(Current),
    append(Current, [Letter], Updated),
    retractall(letters(_)),
    assertz(letters(Updated)),
    write('Letter added successfully.'), nl,
    menu.

% Add a letter at the top
handle_choice(3) :-
    write('Enter a letter: '),
    read(Letter),
    letters(Current),
    Updated = [Letter | Current],
    retractall(letters(_)),
    assertz(letters(Updated)),
    write('Letter added at the top.'), nl,
    menu.

% Add a letter at the bottom
handle_choice(4) :-
    write('Enter a letter: '),
    read(Letter),
    letters(Current),
    append(Current, [Letter], Updated),
    retractall(letters(_)),
    assertz(letters(Updated)),
    write('Letter added at the bottom.'), nl,
    menu.

% Delete a letter
handle_choice(5) :-
    write('Enter the letter to delete: '),
    read(Letter),
    letters(Current),
    ( select(Letter, Current, Updated) ->
        retractall(letters(_)),
        assertz(letters(Updated)),
        write('Letter deleted successfully.'), nl
    ;
        write('Letter not found.'), nl
    ),
    menu.

% Delete all letters
handle_choice(6) :-
    retractall(letters(_)),
    assertz(letters([])),
    write('All letters have been deleted.'), nl,
    menu.

% Exit
handle_choice(7) :-
    write('Thank you for playing the Name Game!'), nl.

% Invalid choice
handle_choice(_) :-
    write('Invalid choice. Please try again.'), nl,
    menu.
