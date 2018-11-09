% Daniel Jimenez
% Homework 6: Paul Tarau

% lib declarations  
:-use_module(library(lambda)).
:-use_module(library(apply)).
:-use_module(library(lists)).

% main function call, similar to that of teachers 
go:-
	go(Board),
	halt(0).
 
% go board function call from main function call declares calls to a create game function, that indicates the starting point, and all pieces, as well as passes board as arg
go(Board):-

% since prolog is a declarative language, so a for loop can not iterate through these calls, therefore they are declared each individually
	create_game([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], Board),
	writeln("Solution at peg 1"),
	display(Board, [1]),
	create_game([2], [1,3,4,5,6,7,8,9,10,11,12,13,14,15], [], Board1),
        writeln("Solution at peg 2"),
	display(Board1, [2]),
	create_game([3], [1,2,4,5,6,7,8,9,10,11,12,13,14,15], [], Board2),
        writeln("Solution at peg 3"),
	display(Board2, [3]),
	create_game([4], [1,2,3,5,6,7,8,9,10,11,12,13,14,15], [], Board3),
        writeln("Solution at peg 4"),
	display(Board3, [4]),
        create_game([5], [1,2,3,4,6,7,8,9,10,11,12,13,14,15], [], Board4),
        writeln("Solution at peg 5"),
        display(Board4, [5]).

%For when our board becomes empty 
create_game(_, [_], Board_Pieces, Board):-
	reverse(Board_Pieces, Board).

% this recursive calls, and selects moves to  make depending on truth table 
create_game(Available, Taken, Board_Pieces, Board):-
	select(S, Taken, Open_1),
	select(Open, Open_1, Open_2),
	select(E, Available, Front),
	moves(S, Open, E),
	create_game([S, Open | Front], [E | Open_2], [moves(S, Open, E) | Board_Pieces], Board).

 
% this declares the moves, similar to in the beginning of the python program for the instructor

moves(S,2,E):-
	member([S,E], [[1,4], [4,1]]).
moves(S,3,E):-
	member([S,E], [[1,6], [6,1]]).
moves(S,4,E):-
	member([S,E], [[2,7], [7,2]]).
moves(S,5,E):-
	member([S,E], [[2,9], [9,2]]).
moves(S,5,E):-
	member([S,E], [[3,8], [8,3]]).
moves(S,6,E):-
	member([S,E], [[3,10], [10,3]]).
moves(S,5,E):-
	member([S,E], [[4,6], [6,4]]).
moves(S,7,E):-
	member([S,E], [[4,11], [11,4]]).
moves(S,8,E):-
	member([S,E], [[4,13], [13,4]]).
moves(S,8,E):-
	member([S,E], [[5,12], [12,5]]).
moves(S,9,E):-
	member([S,E], [[5,14], [14,5]]).
moves(S,9,E):-
	member([S,E], [[6,13], [13,6]]).
moves(S,10,E):-
	member([S,E], [[6,15], [15,6]]).
moves(S,8,E):-
	member([S,E], [[9,7], [7,9]]).
moves(S,9,E):-
	member([S,E], [[10,8], [8,10]]).
moves(S,12,E):-
	member([S,E], [[11,13], [13,11]]).
moves(S,13,E):-
	member([S,E], [[12,14], [14,12]]).
moves(S,14,E):-
	member([S,E], [[15,13], [13,15]]).
 

% this is the display that is called whenever the moves returns a move to do
display([moves(S, M, E) | Tail], Available) :-
	numlist(1, 15, Board_Pieces),
	maplist(\X^I^(member(X, Available) -> I = "."; I = "x"), Board_Pieces, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format("     ~w          ~n", [I1]), 
	format("    ~w ~w        ~n", [I2,I3]),
	format("   ~w ~w ~w      ~n", [I4,I5,I6]),
	format("  ~w ~w ~w ~w    ~n", [I7,I8,I9,I10]),
	format(" ~w ~w ~w ~w ~w  ~n", [I11,I12,I13,I14,I15]),
	select(E, Available, Front),
	display(Tail,  [S, M | Front]).

%  This is the other display, for whenever there are no more available moves for the game to play
display([], Available) :-
	numlist(1, 15, Board_Pieces),
	maplist(\X^I^(member(X, Available) -> I = "."; I = "x"), Board_Pieces,[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format("~n~nSolution~n", [S]),
	format("~n      ~w         ~n", [I1]),
	format("     ~w ~w       ~n", [I2,I3]),
	format("    ~w ~w ~w     ~n", [I4,I5,I6]),
	format("   ~w ~w ~w ~w   ~n", [I7,I8,I9,I10]),
	format("  ~w ~w ~w ~w ~w ~n~n", [I11,I12,I13,I14,I15]),
	writeln("").
