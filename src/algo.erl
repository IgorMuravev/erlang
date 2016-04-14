-module(algo).
-export([prim/1]).


create_k([],Result) -> Result;
create_k([H|T],Result)->
	create_k(T, [[H] | Result]).

another_k(_,_,[]) -> true;
another_k(V1,V2,[H|T]) ->
	Filtered = lists:filter(fun(X) -> X==V1 orelse X==V2 end, H),
	if 
		length(Filtered) == 2 -> false;
		true -> another_k(V1,V2,T)
	end.

prim_iteration(_,[],_) -> error(no_mst);
prim_iteration(K,_,MST) when length(K) == 1 -> MST;

prim_iteration(K, [E | Se],MST) ->
	Ak = another_k(element(1,E), element(2,E), K),
	if 
		 Ak == true ->
			ok;
		_->
			prim_iteration(K,Se, MST)
	end.


prim(Graph) ->
	SortedEdges = lists:sort(fun(X,Y) -> element(3,X) < element(3,Y) end, graph:get_edges(Graph)),
	K = create_k(graph:get_vertex(Graph),[]),
	prim_iteration(K,SortedEdges,[]).
