-module(test_utils).

-export([start_apps/0, stop_apps/0]).

-spec start_apps() -> ok.
start_apps() ->
  {ok, _} = sumo_db_riak:start(),
  init_events().

-spec stop_apps() -> ok.
stop_apps() ->
  ok = sumo_db_riak:stop().

%% @private
init_events() ->
  lists:foreach(fun(EventManager) ->
    gen_event:add_handler(EventManager, EventManager, [])
  end, sumo_config:get_event_managers()).
