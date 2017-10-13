-module(assignment2).

-export([price/1, stretch_if_square/1, convert/1, range_overlap/2,rect_overlap/2, print_0_n/1, print_n_0/1, print2_n_0/1,
	 print_sum_0_n/1, lg/1, count_one_bits/1,
	 print_bits/1, print_bits_rev/1,
	 expand_circles/2, print_circles/1, even_odd/1, even_fruit/1,
         ferry_vehicles/2, ferry_vehicles2/2
        ]).



% 2. Refactoring

price({apple, N}) -> 11 * N; %when the firt argurment is atom apple , mutiply 11 by N.
price({orange, N}) -> 15 * N + 2; % When the first arguement is atom 'orange', mutiply 15 by N and then plus 2.
price({banana, costarica, N}) -> 8 * N;% when the first arguemtn is atom 'banana' and second input is atom 'costarica' , mutiply 8 ny N.
price({banana, equador, N}) -> 9 * N + 2.% when the first arguement is atom 'banana', second arguement is 'equador', mutiply 9 by N and plus 2.


% Do not modify this function
rect_to_square({rect, A, A}) -> {square, A};
rect_to_square({rect, _, _}) -> not_square.

stretch_if_square(R) ->
	X = rect_to_square(R),
	case X of 
		not_square -> R; %when the the result of X is 'not_square' , return R
		{square, A} -> {rect, A, A*2} %otherwise, return tuple {square, A, A*2}. 
	end.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
convert({Unit, Degrees}) -> 
	case Unit of 
		c -> {f,(Degrees * 9/5) +32}; % when the Unit is atom 'c', return the function should convert temperature from Celsius to Fahrenheit.
		f -> {c,(Degrees -32)* 5/9} % when the Unit is atom 'f', return the function that convert temperature from Fahrenheit to Celsius.
	end.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
range_overlap({A,B},{C,D}) when B =< C orelse A >= D -> no_overlap;
range_overlap({A,B},{C,D}) -> {overlap, {max(A,C), min(B,D)}}.
rect_overlap({rect, {X1, Y1}, {X2, Y2}}, {rect, {X3,Y3}, {X4,Y4}}) -> 
	X = range_overlap({X1,X2},{X3,X4}),%Implement th method for X axis
	Y = range_overlap({Y1,Y2},{Y3,Y4}),%Implement the method for Y axis

	case {X,Y} of % In order to have overlap area, both axises need to be overlaped, otherwise there is no overlap 
		{{overlap, _}, {overlap, _}} -> {overlap, {rect, {max(X3,X1), max(Y3,Y1)}, {min(X4,X2), min(Y4,Y2)}}};
		_ -> no_overlap
	end.
	

% 3. Basic recursion

print_0_n(N, N) -> io:format("~p~n", [N]);
print_0_n(N, I) ->
  io:format("~p~n", [I]),
  print_0_n(N, I+1).

print_0_n(N) -> print_0_n(N, 0).

%\\\\\\\\\\\\\\\\\ From 0 and goes up

print_n_0(N, N) -> io:format("~p~n", [N-N]);%when I is the same as N, print 0 (N - N).
print_n_0(N, I) -> 
  io:format("~p~n", [N-I]),%print the result of N - I
  print_n_0(N, I+1).% add up the value of I 

print_n_0(N) -> print_n_0(N, 0).

% |\\\\\\\\\\\\\ Counting down from From N to 0
print2_n_0(0) -> io:format("~p~n", [0]);% until the value of N is minimized to 0, print the value
print2_n_0(N) ->
	io:format("~p~n", [N]), %print the value of N each time
	print2_n_0(N-1). %Minus 1 each time 


%////////////
print_sum_0_n(N,N) -> io:format("~p~n", [N]), N;% Besides printing the the value, it also retunr the the value of N in the end 
print_sum_0_n(N, I) -> 
	io:format("~p~n", [I]),% print the value I
	I + print_sum_0_n(N, I+1).% Adding up the value of I while I is going up by 1 each time 
print_sum_0_n(N) -> print_sum_0_n(N,0).
	
% 4. Recursion on bits

lg(0) -> 0;
lg(N) -> 1 + lg(N div 2).

count_one_bits(0) -> 0;
count_one_bits(N) ->
  (N rem 2) + count_one_bits(N div 2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

print_bits(0) -> ok;%when the N is 0 , print ok
print_bits(N) -> 
	print_bits(N div 2),% Divide N by 2 adn recursively call the function 
	io:format("~p~n", [N rem 2]).%print the reminder of the N 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%First print the reminder and then 
print_bits_rev(0) -> ok; %When the N is 0 return ok
print_bits_rev(N) -> 
	io:format("~p~n", [N rem 2]),%
	print_bits_rev(N div 2).%


% 5. List comprehensions

expand_circles(N, List) -> 
	[{circle, N*X} || {circle, X} <- List].%return the tuple{circle, N*X} where N is the first input and the X is the second input from every touple from List


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
print_circles(L) -> 
	[io:format("~s ~p~n", ["Circle", X]) || {circle, X} <- L],ok.% print the circle and the number X from the given tuple{circle, X}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

even_odd(Num) when Num rem 2 == 0 -> even;
even_odd(_) -> odd.

even_fruit(Fruits) -> 	
	[ Fruit || {Fruit, Quantity} <- Fruits, even_odd(Quantity) == even]. %Exclude Fruit that the quantity  of which is not even , Each Fruits is specified as a tuple {Fruit, Qunatity}
												% Where Fruit is the (String)name of the fuit and Quantity is the quantity of the fruit    
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ferry_vehicles(Res, Vehicles) -> 
	[{V1, V2, W1 + W2} || {V1, W1} <- Vehicles, {V2, W2} <- Vehicles, V1 =/= V2,  W1 + W2 =< Res]. 

ferry_vehicles2(Res, Vehicles) -> 
	[{V1, V2, W1 + W2} || {V1, W1} <- Vehicles, {V2, W2} <- Vehicles, V1 =/= V2,  W1 + W2 =< Res,V1 < V2 ].%In addition to the code from previous function, 
																										%Comparing the atom name 'v1' and 'V2' so that that there wont be duplicate combination appearing 



