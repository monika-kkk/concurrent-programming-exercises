-module(err).
-compile([export_all]).

myproc() ->
	timer:sleep(5000),
	exit(reason). %something like crash
	
mp2() ->
	timer:sleep(5000).
	

chain(0) ->
	receive
		_ -> ok
	after 2000 ->
		exit("chain dies here")
	end;
	
chain(N) ->
	Pid = spawn(fun() -> chain(N-1) end), %if this process dies, our process dies
	link(Pid),
	receive
		_ -> ok
	end.
	
%System processes can convert exit signals to regular messages

%process_flag(trap_exit, true). <- set in shell
%spawn_link(fun() -> linkmon:chain(3) end). <- erl function, anonymous function calls defined function


%Monitors
%erlang:monitor(process, spawn(fun() -> timer:sleep(500) end))
%#Ref<0.0.0.77>
%2> flush().
%Shell got {'DOWN',#Ref<0.0.0.77>,process,<0.63.0>,normal}
%ok

% PID != REF
% {Pid, Ref} = spawn_monitor(fun() -> receive _ -> exit(boom) end end).
% erlang:demonitor(Ref, [flush,info])
% info - informs if process existed, flush - remove down message from mailbox


start_critic() ->
	spawn(?MODULE, restarter, []).
	
	
critic() ->
	receive
	{From, {"Rage Against the Turing Machine", "Unit Testify"}} ->
	From ! {self(), "They are great!"};
	{From, {"System of a Downtime", "Memoize"}} ->
	From ! {self(), "They're not Johnny Crash but they're good."};
	{From, {"Johnny Crash", "The Token Ring of Fire"}} ->
	From ! {self(), "Simply incredible."};
	{From, {_Band, _Album}} ->
	From ! {self(), "They are terrible!"}
	end,
	critic().	
	
	
judge(Pid, B, A) ->
	Pid ! {self(), {B, A}},
	receive
		{Pid, Criticism} -> Criticism
	after 2000 ->
		timeout
	end.
	
judge2(Band, Album) ->
	critic ! {self(), {Band, Album}}, 
	Pid = whereis(critic), %check critic PID, RACE CONDITION <- depends on the timing of events
	receive
		{Pid, Criticism} -> Criticism
	after 2000 ->
		timeout
	end.
		
	
%exit(Critic, storm)
%like shell
restarter() ->
	process_flag(trap_exit, true),
	Pid = spawn_link(?MODULE, critic, []), %for all critics?
	register(critic, Pid),
receive
	{'EXIT', Pid, normal} -> % not a crash
	ok;
	{'EXIT', Pid, shutdown} -> % manual termination, not a crash
	ok;
	{'EXIT', Pid, _} ->
	restarter() %if it gets message, it calls restarter()
end.
%normal, shutdown - known atoms



%TODO traps, solve race condition
%http://learnyousomeerlang.com/errors-and-processes