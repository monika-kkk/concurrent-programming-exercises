%  lye.erl
-module(lye).
-compile([export_all]).

sum() ->
	2 + 2.
  
sum2(A, B) ->
	fun() -> A + B end. 

newProcess() -> spawn(lye,sum,[]). %returns PID

printNumber(X) ->
	timer:sleep(1000),
	self() ! self() ! hello, %send atom to process with pid, returns what I sent, it's stored in something like mailbox
	io:format("~p~n", [X]).

%spawn runs function, returns PID
%
runProcesses() -> [spawn(lye, printNumber,[X]) || X <- lists:seq(1,10)].

%If we want to reply, we need know whoch process sent message
dolphin() ->
	receive
		{From, do_a_flip} ->
			From ! "A",
			dolphin();
		{From, fish} ->
			From ! "B";
		_ ->
			io:format("AM"),
			dolphin()
	end.
	
%other syntax (guards)
%receive
%Pattern1 when Guard1 -> Expr1;
%Pattern2 when Guard2 -> Expr2;
%Pattern3 -> Expr3
%end
	
fridge(FoodList) -> 
	receive
		{From, {store, Food}} ->
			From ! {self(), ok},
			fridge([Food|FoodList]); % separation with ,
		{From, {take, Food}} ->
			case lists:member(Food, FoodList) of
				true ->
					From ! {self(), {ok, Food}},
					fridge(lists:delete(Food, FoodList));
				false -> 
					From ! {self(), not_found},
					fridge(FoodList)
			end;
		terminate ->
			ok
	end.
	
	
% when this function is called, shell process is in receive mode
store(Pid, Food) -> 
		Pid ! {self(), {store, Food}},
		receive
			{Pid, Msg} -> Msg %we receive it from fridge, return only msg
		after 3000 ->
			timeout %shell stop waiting
		end.

take(Pid, Food) ->
	Pid ! {self(), {take, Food}},
	receive
		{Pid, Msg} -> Msg
	after 3000 ->
		timeout
	end.
	
% kitchen:take(pid(0,250,0),dog) <- change integers into PID
%send message, switch to receive mode and wait for message - frozen if incorrect PID

	
start(FoodList) ->
	spawn(?MODULE, fridge, [FoodList]).	
	
	
sleepM(T) ->
	receive
		after T -> ok
	end.
	
% see the contents of 'mailbox'	
flushM() ->
	receive
		_ -> flushM()
	after 0 ->
		ok
	end.
	
%selective receive, erlang check all queue
important() ->
	receive
		{Priority, Message} when Priority > 10 ->
			[Message | important()]
		after 0 ->
			normal()
	end.
	
normal() ->
	receive
		{_, Message} ->
			[Message | normal()]
	after 0 ->
		[]
	end.
	
%receive
%Pattern1 -> Expression1;
%Pattern2 -> Expression2;
%Pattern3 -> Expression3;
%PatternN -> ExpressionN;
%Unexpected ->
%io:format("unexpected message ~p~n", [Unexpected])
%end.
	
			
%erlang can skip some messages	
	
% f() reset variable

%why erlang processes are efficient?
%why concurrency is more efficient?
%tail recursive - low-level
