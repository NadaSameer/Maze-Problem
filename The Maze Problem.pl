:-use_module(library(lists)).

move(gateB,gateA).
move(gateA,gateB).
move(gateA,gateG).
move(gateB,gateC).
move(gateB,gateH).
move(gateC,gateD).
move(gateH,gateO).
move(gateD,gateI).
move(gateI,gateP).
move(gateP,gateQ).
move(gateD,gateJ).
move(gateJ,gateR).
move(gateG,gateL).
move(gateL,gateS).
move(gateG,gateF).
move(gateE,gateK).
move(gateP,end).
move(end,home).

%Another Maze Example
%move(gateA,gateB).
%move(gateA,gateC).
%move(gateB,gateO).
%move(gateC,gateO).
%move(gateO,hall).

goSolveTheMaze(Start,Goal):-
path([[Start,null]],[],Goal).

path([],_,_):-
    write('No solution found'),nl,!.
path([[Goal,Parent] | _], Closed, Goal):-
    write('A solution is found'), nl,
    printsolution([Goal,Parent],Closed),!.
path(Open, Closed, Goal):-
    removeFromOpen(Open, [State, Parent], RestOfOpen),
    getchildren(State, Open, Closed, Children),
    addListToOpen(RestOfOpen,Children, NewOpen),
    path(NewOpen, [[State, Parent] | Closed], Goal).

getchildren(State, Open ,Closed , Children):-
    bagof(X, moves( State, Open, Closed, X), Children), ! .
getchildren(_,_,_, []).

addListToOpen(Children,[],Children).
addListToOpen(L, [H|Open], [H|NewOpen]):-
    append(L, Open, NewOpen).

removeFromOpen([State|RestOpen], State, RestOpen).
moves( State, Open, Closed,[Next,State]):-
    move(State,Next),
    \+ member([Next,_],Open),
    \+ member([Next,_],Closed).

printsolution([State, null],_):-
    write(State),nl.
printsolution([State, Parent],NewOpen ):-
    member([Parent, GrandParent], NewOpen),
    printsolution([Parent, GrandParent], NewOpen),
    write(State), nl.

