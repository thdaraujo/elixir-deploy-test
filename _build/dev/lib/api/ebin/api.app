{application,api,
             [{applications,[kernel,stdlib,elixir,logger,runtime_tools,
                             gettext,phoenix_pubsub,cowboy,phoenix_html,
                             phoenix,phoenix_live_reload]},
              {description,"api"},
              {modules,['Elixir.Api','Elixir.Api.Application','Elixir.ApiWeb',
                        'Elixir.ApiWeb.Endpoint','Elixir.ApiWeb.ErrorHelpers',
                        'Elixir.ApiWeb.ErrorView','Elixir.ApiWeb.Gettext',
                        'Elixir.ApiWeb.LayoutView',
                        'Elixir.ApiWeb.PageController',
                        'Elixir.ApiWeb.PageView','Elixir.ApiWeb.Router',
                        'Elixir.ApiWeb.Router.Helpers',
                        'Elixir.ApiWeb.UserSocket']},
              {registered,[]},
              {vsn,"0.0.1"},
              {mod,{'Elixir.Api.Application',[]}},
              {extra_applications,[logger,runtime_tools]}]}.