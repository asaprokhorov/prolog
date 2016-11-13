parent(volodymyr, viktor).
parent(volodymyr, natalya).
parent(galyna, viktor).
parent(galyna, natalya).
parent(viktor, sergiy).
parent(oksana_lemekha, sergiy).
parent(oleksiy, kostyantyn).
parent(oleksiy, andriy).
parent(iryna, kostyantyn).
parent(iryna, andriy).
parent(kostyantyn, oleksandr).
parent(kostyantyn, dmytro).
parent(natalya, oleksandr).
parent(natalya, dmytro).
parent(andriy, maksym).
parent(andriy, makar).
parent(oksana_prokhorova, maksym).
parent(oksana_prokhorova, makar).
man(volodymyr).
man(viktor).
man(sergiy).
man(oleksiy).
man(kostyantyn).
man(andriy).
man(oleksandr).
man(dmytro).
man(maksym).
man(makar).
woman(galyna).
woman(natalya).
woman(oksana_prokhorova).
woman(oksana_lemekha).
woman(iryna).
married(natalya, kostyantyn).


child(X, Y) :- parent(Y, X).
mother(X, Y) :- parent(X, Y), woman(X).
father(X, Y) :- parent(X, Y), man(X).
grand_parent(X, Y) :- parent(X, Z), parent(Z, Y).
brother(X, Y) :- parent(Z, X), parent(Z, Y), man(X), X \= Y.
sister(X, Y) :- parent(Z, X), parent(Z, Y), woman(X).
sibling(X, Y) :- parent(Z, X), parent(Z, Y).
cousin(X, Y) :- grand_parent(Z, X), grand_parent(Z, Y).
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Y, Z), descendant(X, Z).

rule(X, Y) :- ancestor(X, Z), parent(Y, Z), not(ancestor(X, Y)).

siblings_s(X, Y) :- parent(Z, X), parent(Z, Y).
siblings_s(X, Y) :- parent(Z, X), siblings_s(Z, A), parent(A, Y). 