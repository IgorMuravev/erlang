%% this module loads Graph from txt files.
%% Graph is the tuple, which consists of List of Verttex & List of Edges
%% Like this {graph, V, E}.

-module(db).
-export([load/1]).


clear_string(Str) ->
	string:strip(string:strip(Str,both,$\n)).

get_tuple(Str) ->
	[V1,V2,W |_] =string:tokens(Str,";"),
	{V1,V2,element(1,string:to_integer(W))}.

str_to_edge(Str) ->
	get_tuple(clear_string(Str)).

str_to_vertex(Str) ->
	clear_string(Str).

str_to_header(Str)->
	[Vc,Ec | _ ] = string:tokens(clear_string(Str), ";"),
	{element(1,string:to_integer(Vc)), element(1,string:to_integer(Ec))}.
	
p_load_header(Device)->
	Ans = file:read_line(Device),
	if
		is_tuple(Ans)->
			{X,Data} = Ans,
			case X of 
				ok ->  str_to_header(Data);
				_ -> Ans
			end;
		true -> Ans
	end.


p_load(Path) ->
	{X, Device} = file:open(Path,[read]),
	case X of
		ok ->
			Header = p_load_header(Device),
			Vertex = p_read(fun str_to_vertex/1 ,Device,[],element(1, Header)),
			Edges = p_read(fun str_to_edge/1, Device, [], element(2, Header)),
			{graph, Vertex, Edges};
		_ -> {X,Device}
	end.

p_read(_,_,Accum,0) -> Accum;
p_read(F,Device,Accum, Count)->
	Ans = file:read_line(Device),
	if 
		is_tuple(Ans) ->
			{X, Data} = Ans,	 
			case X of
				ok -> p_read(F,Device,[F(Data) | Accum], Count - 1);
				_-> {X, Data}
			end;
		true ->
			Accum
	end.


load(Path) -> 
	p_load(Path).
