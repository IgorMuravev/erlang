-module(algo).
-export([prim/1]).

prim(Graph) ->
	SortedEdges = lists:sort(fun(X,Y) -> element(3,X) < element(3,Y) end, graph:get_edges(Graph)).