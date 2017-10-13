-module(assignment4_counter).

%% DO NOT CHANGE THE EXPORT STATEMENT!
-export([start/0, init/0, incr/1, fetch/1, reset/1, stop/1
        ]).
%% End of no-change area

%Start the process by spawning a new process
start() -> spawn(assignment4_counter, init, []). % spawning a process 

%initialize the server wiht auxilary function init/1 with an initial arguement 0
init() -> init(0).

%This server function takes a variable Val as input, Val will keeo track of the number
%if the server process receice message 'increment'(sent by incr()), it will increase Val by 1
%if it receive the tuple contains 'accumulate', 
%it will return the current Val to the pid that tuple has contained(Where)  
%When receiving message 'reset', reset the value of Val to 0
%When receiving message 'stop', return ok to stop the process
%Otherwise, keep looping the server  
init(Val) -> 
	receive 
		increment -> init(Val +1); 
		{Pid,accumulate} -> Pid ! Val,init(Val); 
		reset -> init(0);
		stop -> ok;
		_ -> init(Val)
	end.

%This process take the process as the input 
%and will send message 'increment' to the server
incr(Counter) -> Counter ! increment, ok.

%
%This function takes the process as input 
%and will send a tuple that contains its currnet process pid and message 'accumululate' to the server
fetch(Counter) -> 
	Counter ! {self(),accumulate},
	receive
		Val -> Val
	end.

%
%this function takes a process as input, send the message 'reset' to the server
%then return ok
reset(Counter) -> Counter ! reset, ok.

%Send a message 'stop' and then return ok
stop(Counter) -> Counter! stop, ok.
