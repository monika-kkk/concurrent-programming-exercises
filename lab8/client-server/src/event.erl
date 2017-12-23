-module(event).
-compile(export_all).
-record(state, {server, name="", to_go=0}).

loop(S = #state{server = Server, to_go = [T|Next]}) -> %?????????
	receive
		{Server, Ref, cancel} -> %Ref - unique message identifier
			Server ! {Ref, ok}
	after T*1000 ->
		if Next =:= [] ->
			Server ! {done, S#state.name};
		   Next =/= [] ->
		    loop(S#state{to_go=Next}) %constructor/setter
		end
			
	end.

% We want to know from which process message comes
%12> ReplyRef = make_ref().
%#Ref<0.0.0.210>
%13> Pid ! {self(), ReplyRef, cancel}.

normalize(N) -> 
	Limit = 49*24*60*60,
	[N rem Limit | lists:duplicate(N div Limit, Limit)].
	

% ordinary function, calling self() returns shell PID
start(EventName, Delay) ->
	spawn(?MODULE, init, [self(), EventName, Delay]).
	
start_link(EventName, Delay) ->
	spawn_link(?MODULE, init, [self(), EventName, Delay]).
	

init(Server, EventName, DateTime) ->
	loop(#state{server=Server, name=EventName, to_go=time_to_go(DateTime)}).
	
cancel(Pid) ->
	Ref = erlang:monitor(process, Pid),
	Pid ! {self(), Ref, cancel},
	receive
		{Ref, ok} ->
			erlang:demonitor(Ref, [flush]), %?????
			ok;
		{'DOWN', Ref, process, Pid, _Reason} ->
			ok
		end.
			
			
			
time_to_go(Timeout={{_,_,_},{_,_,_}}) -> %format specification?
	Now = calendar:local_time(),
	ToGo = calendar:datetime_to_gregorian_seconds(Timeout) -
		   calendar:datetime_to_gregorian_seconds(Now),
	Secs = if ToGo > 0  -> ToGo;	
			  ToGo =< 0 -> 0
	       end,
	normalize(Secs).
			   
			
			
			
			
			
			
			
			
			
			
			