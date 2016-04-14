-module(main).
-export([entry_point/0]).

entry_point()->
	Graph = db:load("..\\data\\graph.txt"),
	algo:prim(Graph).