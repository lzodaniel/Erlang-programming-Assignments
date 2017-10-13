-module(assignment4).

%% DO NOT CHANGE THE EXPORT STATEMENT!
-export([task/1, dist_task/1, pmap/2, faulty_task/1
        ]).
%% End of no-change area


%%
%% Process handling
%%

%% Do not change the following two functions!
task(N) when N < 0; N > 100 ->
    exit(parameter_out_of_range);
task(N) ->
    timer:sleep(N * 2),
    256 + 17 *((N rem 13) + 3).

faulty_task(N) when N < 0; N > 100 ->
    exit(parameter_out_of_range);
faulty_task(N) ->
    timer:sleep(N * 2),
    {_,_,X} = now(),
    case X rem 10 == 0 of
        false ->
            256 + 17 *((N rem 13) + 3);
        true  ->
            throw(unexpected_error)
    end.
%% End of no-change area

%%  Initialize variable Pid1 to the pid of current process
%a Initialize Pid 2 to the pid of each spawning process for process each element of the NL by using task()
%When receiving the message , we need to return the result in a rigth order by sequently passing the value that sent by the 
%corresponded pid to the result list. 
dist_task(NL) ->
    Pid1 = self(),
    Pid2 = [ spawn(fun() -> Pid1 ! {self(),task(Y)} end) || Y <- NL ],
    
    [receive {Where, Result} -> Result end|| Where <- Pid2]. 

%Initialize variable Pid1 to the pid of current process
%Initialize Pid2 to the process id of each sapwning process 
%that handle each element of input List (L). In addition the bif catch()
% was used in case of cashing of the process, so it could catch the error message and retunr it 
%At last, when received the message sent from every spawned process, 
%we need to return the result in a rigth order by sequently passing the value that sent by corresponded pid to the result list. 
pmap(Func, L) ->
    Pid1 =self(),
    Pid2 = [ spawn(fun() -> Pid1 ! {self(), catch(Func(X))} end ) || X <- L],
    [receive {Where,Result} -> Result end|| Where <- Pid2].


%%
%% Problem 4
%%

% Write your answer here
% According to the sequence of message printed, the process g() should be executed first 
% and the io:format printing should be executed last. This is due to the fact that all these process take the server
%as the arguement, and the server would keep track of the value of N,
% since there is no operation that reduce the value of both two variables
% the the value that are returned/printed can only be bigger not smaller.

%Since test() fisrt print 3 and there is ony add(P,3) in test()that can add value of 3 in the server, so add(P.3)
%was executed first. Then the value printed by g() is 5 due to the fact that add(P,2) is executed 
%before the value N in the server was printed. Finally, since there is only f() left, that process will be 
% executed (spawn(a4p4, f, [p])). Consequently, inside f(), the value of N in the server will be added by 1,
%which is  5 + 1 =6. Therefore, the first line of code should be 
%          f() read 6  %






