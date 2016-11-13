first(Y, [Y|T]).

right(X, Y, [X, Y]).
right(X, Y, [X|T]) :- first(Y, T).
right(X, Y, [H|T]) :- right(X, Y, T).

next_to(X, Y, L) :- right(X, Y, L);right(Y, X, L).

write_list([H|L]) :- write(H), write("\n"), write_list(L).

solve(Solution):- length(Solution,5),						% 1
	member([english,_,_,_,red],Solution), 					% 2
	member([spanish,dog,_,_,_],Solution),  					% 3
	member([_,_,_,coffee,green],Solution),					% 4
	member([ukrainian,_,_,tea,_],Solution),					% 5 
	next_to([_,_,_,_,green],[_,_,_,_,white], Solution),		% 6
	member([_,snake,winston,_,_],Solution), 				% 7
	member([_,_,kool,_,yellow],Solution),					% 8
	Solution= [_,_,[_,_,_,milk,_],_,_],						% 9	
    Solution= [[norwegian,_,_,_,_],_,_,_,_],   				% 10
	next_to([_,_,chesterfield,_,_],[_,fox,_,_,_],Solution), % 11
	next_to([_,_,kool,_,_],[_,horse,_,_,_], Solution),		% 12
	member([_,_,lucky,juice,_],Solution),					% 13
	member([japanese,_,kent,_,_],Solution),					% 14
	next_to([norwegian,_,_,_,_],[_,_,_,_,blue],Solution), 	% 15
	member([_,_,_,water,_],Solution),						% someone drinks water
	member([_,zebra,_,_,_],Solution), !.  					% someone has a zebra


