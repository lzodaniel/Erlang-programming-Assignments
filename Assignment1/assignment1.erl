-module(assignment1).

-export([even_odd/1, range_overlap/2, rect_overlap/2,get_amp/1,
 f2c/1, c2f/1, convert/1, measure/3, any_2_equal/3]).

% Part 2
% -----------------------

even_odd(Num) when Num rem 2 == 0 -> even;
even_odd(_) -> odd.

range_overlap({A,B},{C,D}) when B =< C orelse A >= D -> no_overlap;% Because B is smaller than or equal to C, since B is the Maxium value of first tuple and C is the Minimum value of second touple , there is no overlap
																%Since A is the minimum value of first touple and D is the Maximum value of the second touple, so if C is greater or equal than D, there is no overlap.													
range_overlap({A,B},{C,D}) -> {overlap, {max(A,C), min(B,D)}}. %Otherwise, there is overlap. The overlap range should always start with the maximum value of the initial value from each given range and end with the maximum number of the last value of each given range.


rect_overlap({rect, {X1, Y1}, {X2, Y2}}, {rect, {X3,Y3}, {X4,Y4}}) 
	when (X2 =< X3 orelse X1 >= X4) orelse (Y3 >= Y2 orelse Y1 >= Y4) -> no_overlap;%This when guard condition is another re-implementaion of that in function 'range_overlap/2',
																					%just need to replace the variable name with the given arguement(X1,X2,Y1,Y2 etc.) accordingly.  
																					%(e.g. The FIRST PART is comaring condition for the X-axis, and the second part is the comparing condition for the Y-axis ).
rect_overlap({rect, {X1, Y1}, {X2, Y2}}, {rect, {X3,Y3}, {X4,Y4}}) -> 
	{overlap, {rect, {max(X3,X1), max(Y3,Y1)}, {min(X4,X2), min(Y4,Y2)}}}. %Otherwise, there is overlap. The range calculation should also be done by implementing 
	                                                                       %that of the 'range_overlap' accordingly.

get_amp({_Amplifer, {_PreAmp, Pre_Factor}, Factor, _Noise}) -> Factor + Pre_Factor;
get_amp({_Amplifer, _No_PreAmp, Factor , _Noise}) -> Factor.

f2c(Degrees) -> (Degrees -32)* 5/9.  
c2f(Degrees) -> (Degrees * 9/5) +32.

convert({c, Degrees}) -> {f,c2f(Degrees)}; 
convert({f, Degrees}) -> {c,f2c(Degrees)}.
% Part 3
% -----------------------

measure(X, N, N) -> X + 1;
measure(X, N, M) -> X + N - M.


any_2_equal(_A, _B, _A) -> true;
any_2_equal(_A, _A, _C) -> true;
any_2_equal(_A, _B, _B) -> true;
any_2_equal(_A, _B, _C) -> false.

