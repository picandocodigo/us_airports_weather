defmodule WeatherWeb.Router do
  use WeatherWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :browser
    plug BasicAuth, use_config: {:weather, :weather_config}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WeatherWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/airports", AirportController, only: [:index, :show]
  end

  scope "/admin", WeatherWeb do
    pipe_through :admin
    resources "/airports", AirportController, only: [:new, :create, :edit, :update, :delete]
  end


  # Other scopes may use custom stacks.
  # scope "/api", WeatherWeb do
  #   pipe_through :api
  # end
end
