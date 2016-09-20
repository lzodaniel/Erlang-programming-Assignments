-module(assignment3).

-export([sum/1, sum_interval/2, interval/2,
	 sum_interval2/2, adj_duplicates/1,
	 even_print/1, even_odd/1, even_print2/1,
	 normalize/1, maxilize/2, normalize2/1,
         sum2/1, last/1, mul/1, find/2, sort/1,
         dict_new/0, dict_get/2, dict_put/3,
         dict_wellformed/1, dict_map_values/2,
         tree_leaf/0, tree_branch/3, tree_deconstruct/1,
         tree_wellformed/1, tree_make_bfs/1, tree_bind/2,
         tree_flatten/1, tree_dfs/1, tree_sorted/1, tree_find/2,
         digitize/1, is_happy/1, all_happy/2,
         expr_eval/1, expr_print/1
        ]).


% 1. Basic functions, lists and tuples

% Do not modify this function
sum([])     -> 0;
sum([X|Xs]) -> X + sum(Xs).

sum_interval(N, M) when N > M -> 0;%when N > M , return 0
sum_interval(N, M) -> N + sum_interval(N+1, M). %increment A by one each time , and accumulate the result by using 'A+'

interval(N, M)when  N > M-> [];%When N > M, return empty list
interval(N, M) -> [N] ++ interval(N+1, M).% Increment N by one each time

sum_interval2(N, M) -> sum(interval(N,M)).%calculating the sum by utilizing sum() and interval()

adj_duplicates([]) -> [];%when the input list empty, return empty list
adj_duplicates([X,X|Xs]) -> [X]++ adj_duplicates([X|Xs]);%Take the head of the list and merge with the head of the tail , do so recursively 
adj_duplicates([_|Xs]) -> adj_duplicates(Xs).% until there i only one element left in the input list, retunr the element 


even_print([]) -> ok;%when there is nothing ..return empty list
even_print([H|T]) when H rem 2 ==0 -> io:format("~p~n", [H]), even_print(T);%when the head is even number, print that number and continue to go through the rest of the list recusively 
even_print([_|T]) -> even_print(T). %when there is only one elelment left, return that number

even_odd(N) when N rem 2 == 0 -> even; % when the reminder of result of N divide by 2 is 0, then this number is even number, thus retunr atom 'even' 
even_odd(_) -> odd.%Otherwise, return atom 'odd'

even_print2(L) -> [io:format("~p~n", [X]) || X <- L, even_odd(X) == even], ok.

normalize(L) ->[X /maxilize(L, hd(L)) || X<- L].

maxilize([],Max) -> Max;
maxilize([X|Xs], Max) -> 
	if Max >= X -> maxilize(Xs, Max);
	 true -> maxilize(Xs, X)
	end.


normalize2(L) -> lists:map(fun(X) -> X/maxilize(L, hd(L)) end, L).


sum2(L) -> 
	case L of
		[] -> 0;
		[X|Xs] -> X + sum2(Xs)
	end.

last([X]) -> X;
last([_|Xs]) -> last(Xs).

mul([X|Xs]) -> X*mul(Xs);
mul([]) -> 1.

find(_,[])  -> not_found;
find(Predicate, [H|T]) -> 
	F = Predicate(H),
if 
	F(H) == true -> {found, H};
	true -> find(Predicate, T)
end.


%find(Predicate, [H|T]) -> F =


sort(_) -> not_implemented.


% 3. Dictionary

dict_new() -> not_implemented.

dict_get(_, _) -> not_implemented.

dict_put(_, _, _) -> not_implemented.

dict_wellformed(_) -> not_implemented.

dict_map_values(_, _) -> not_implemented.


% 4. Treeszdfsdfs

tree_leaf() -> not_implemented.

tree_branch(_, _, _) -> not_implemented.

tree_deconstruct(_) -> not_implemented.

tree_wellformed(_) -> not_implemented.

tree_make_bfs(_) -> not_implemented.

tree_bind(_, _) -> not_implemented.

tree_flatten(_) -> not_implemented.

tree_dfs(_) -> not_implemented.

tree_sorted(_) -> not_implemented.

tree_find(_, _) -> not_implemented.


% 5. Digitify a number 

digitize(N) when N <10 andalso N>0 -> [N];
digitize(N) when N >=10 -> digitize(N div 10) ++ [N rem 10].

% 6. Hppy numbers

calculate(N) -> [X*X || X <-N].

%is_happy(N) when sum(calculate(digitize(N))) = 1 -> true;
%is_happy(N) when sum(calculate(digitize(N))) = 4 -> false;
is_happy(N)
	when N >0 ->
	X =sum(calculate(digitize(N))),
	if
		X == 1 -> true;
		X == 4 -> false;
		true -> is_happy(X)
	end.

all_happy(_N, _M) -> not_implemented.


% 7. Expressions

expr_eval(_Expr) -> not_implemented.

expr_print(_Expr) -> not_implemented.

