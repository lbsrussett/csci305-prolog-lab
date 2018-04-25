% Laura Sullivan-Russett
% CSCI 305 Prolog Lab 
% May 2, 2018

% mother/2
% M is the mother of C if M is the parent of C and M is female
mother(M,C):- 
	parent(M,C), 
	female(M).

% father/2
% F is the father of C if F is the parent of C and F is male
father(F,C):- 
	parent(F,C), 
	male(F).

% spouse/2
% S1 is the spouse of S2 if S1 and S2 are married
spouse(S1, S2):-
	married(S1, S2) ;
	married(S2, S1).

% child/2
% C is the child of P if P is the parent of C
child(C, P):-
	parent(P, C).

% son/2
% C is the son of P if C is a child of P and C is male
son(C, P):-
	child(C, P),
	male(C).

% daughter/2
% C is the daughter of P if C is the child of P and C is female
daughter(C, P):-
	child(C, P),
	female(C).

% sibling/2
% S1 and S2 are siblings if they share the same mother and father and 
% S1 and S2 are not the same person
sibling(S1, S2):-
	mother(M, S1), mother(M, S2),
	father(F, S1), father(F, S2),
	S1 \= S2.

% brother/2
% Bro is the brother of S if Bro is the sibling of S and Bro is male
brother(Bro, S):-
  sibling(Bro, S),
  male(Bro).

% sister/2
% Sis is the sister of S if Sis is the sibling of S and Sis is female
sister(Sis, S):-
	sibling(Sis, S),
	female(Sis).

% uncle/2 by blood
% U is the uncle of N if U is male and U is a sibling of a parent of N
uncle(U, N):-
	male(U), 
	parent(P, N),
	sibling(U, P).

% aunt/2 by blood
% A is the aunt of N if A is female and A is a sibling of a parent of N
aunt(A, N):-
	female(A),
	parent(P, N),
	sibling(A, P).

% uncle-inlaw/2 by marriage 
% U is an uncle by marriage if U is male and married to an aunt of N 
uncle-inlaw(U, N):-
	spouse(U, A), 
	aunt(A, N).

% aunt-inlaw/2 by marriage
% A is an aunt by marriage if A is female and married to an uncle of N
aunt-inlaw(A, N):-
	spouse(A, U),
	uncle(U, N).

% grandparent/2
% GC is the grandchild of G if G is a parent of P who is a parent of GC
grandparent(G, GC):-
	parent(G, P),
	parent(P, GC).

% grandfather/2
% GF is the grandfather of GC if GF is male and is a grandparent of GC
grandfather(GF, GC):-
	male(GF),
	grandparent(GF, GC).

% grandmother/2
% GM is the grandmother of GC if GM is female and is a grandparent of GC
grandmother(GM, GC):-
	female(GM),
	grandparent(GM, GC).

% grandchild/2
% GC is a grandchild of GP if GP is the grandparent of GC
grandchild(GC, GP):-
	grandparent(GP, GC).

% ancestor/2
% A is an ancestor of D if A is a parent of D (base case)
% Otherwise, A is an ancestor of D if A is an ancestor of P and P is a parent of D
ancestor(A, D) :- 
	parent(A, D).
	ancestor(A, D) :-
	parent(P, D),
	ancestor(A, P).

% descendant/2 
% D is a descendant of A if a is an ancestor of D 
descendant(D, A):-
	ancestor(A, D).

% older/2
% O is older than Y if O is born in a year that is before the year that Y was born
older(O, Y):-
	born(O, X),
	born(Y, Z),
	X < Z.

% younger/2
% Y is younger than O if Y is born in a year that is after the year that O was born
younger(Y, O):-
	born(Y, X),
	born(O, Z),
	X > Z.

% regentWhenBorn/2
% R reigned when P was born if P was born in a year greater than or equal to the first
% year that R reigned and less than or equal to the last year that R reigned
regentWhenBorn(R, P):-
	reigned(M, X, Y),
	born(P, B),
	B >= X,
	B =< Y ->
	R = M.

%cousin/2
% C1 is the cousin of C2 if C2 is the child of the aunt or uncle of C1 
cousin(C1, C2):-
	aunt(A, C1),
	child(C2, A) ; 
	uncle(U, C1),
	child(C2, U).



