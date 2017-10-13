-module(assignment4_store).

%% DO NOT CHANGE THE EXPORT STATEMENT!
-export([start/0, init/0, stop/0, store/2, fetch/1, flush/0
        ]).
%% End of no-change area

% chceck of status of process sts, if ti is not alive, spwan the process and register it with the name 'sts', 
% then return the {ok, PID( the process id)},
%if there is already a Pid, then just return the tuple with ok and the Pid  
start() -> 
	case whereis(sts) of 
		undefined -> PID = spawn(assignment4_store, init, []),
		register(sts, PID),
		{ok,PID};
		PID -> {ok,PID}
	end.

%make a case of the pid of sts, if it is not undefiend, it means its not running anymore 
%and therefore we return message 'already stopped'
%If the process is still running, send message 'stop' to the process and wait for the server to terminate the process, 
%meanwhile, return message 'stop'

stop() ->
	Y = whereis(sts),
	case Y of
		undefined -> already_stopped;
		_Pid -> sts ! stop ,stopped
	end.

%This function takes 2 arguements: the key and the value that is assigned to it. 
%First send the message that contains the pid and the tuple include the key and its assosicated value 
%After receiveing the message {not_found}, return it, if the server return the message with result ,
%return the tuple with atom ok and the result
store(Key, Val) ->
	sts ! {store,self(),{Key,Val}},
	receive
		{not_found} -> {ok,no_value};
		{done,X} -> {ok,X}
	end.

%This function take Key as arguemtns
%First send the pid of the current process and the key of the associated value which user wish to fetch
%If tuple {not_found} is received, just return the tuple {error, not_found}. Else, 
%if received Result (assocaited value), return it with ok in atuple

fetch(Key) -> sts ! {fetch,self(),Key},
	receive 
		{not_found} -> {error,not_found};
		Result -> {ok,Result}
 	end.

%This function send the current process a message with the current pid and the atom 'flush'
%when it received the message 'flushed', will return the tuple{ok,flushed} as requested 
%
flush() -> sts ! {self(),flush},
	receive 
		flushed -> {ok,flushed}
	end.
%the  function thta initialze the server process init/1
init() -> init([]).


%the server process take a list as input 
%when it receive the message from store/2, which contains the pid of the process the store is running 
%and the Key that Val is associated with, initialize variable Output to the result of proplists:get_value
%If the result of Output is 'undefined', Send the messgae {not_found} and store the the Key, correlated pid and values
%if there is the stored value(_X), send a message {done,Output(the result)} back andreplace the Key,pid(Where) and
% the Val accordingly by using lists:keyreplace/4
%When message 'stop' received, return 'stopped' and the process is therefore stopped
%When recieving message from fetch/2, repeat the procedure of when receiving message from store,
%then make a case for it, if it is undefined, then send message {nnot_found} back, while keeping the server alive.
%If there is values returned, send the back the result and keep looping the server
%If message from flush/0 is received, first send message 'flushed' back 
%and then initialize a list comprehension that filter every tuple that has the same pid as the one sent(Where)  

init(L) ->

	receive 
		{store,Where,{Key,Val}} -> 
			Output = proplists:get_value({Where,Key},L),
			case Output of
				undefined -> Where ! {not_found},init([{{Where, Key},Val}|L]);
				_X -> Where ! {done,Output}, 
				NewList = lists:keyreplace({Where,Key},1,L,{{Where, Key},Val}),init(NewList)
			end;

		stop -> stopped;

		{fetch, Where,Key} -> 
		Output = proplists:get_value({Where,Key},L),
			case  Output of
				undefined -> Where ! {not_found},init(L);
				_X -> Where ! Output,init(L)
			end;
		{Where, flush} -> Where !flushed,init([{{Pid,Key},Val} || {{Pid,Key},Val} <- L, Pid /= Where])


	end.
			
		








	
