%% Graph is the tuple, which consists of List of Verttex & List of Edges
%% Like this {graph, V, E}.
-module(graph).
-export([get_vertex/1,get_edges/1]).

get_vertex({graph,V, _}) -> V.
get_edges({graph,_,E}) -> E.