defmodule FoodTrucksWeb.FoodTrucksFindersLive.Index do
  use FoodTrucksWeb, :live_view

  alias FoodTrucks.FoodTruckFinder
  alias FoodTrucks.FoodTruckFinder.FoodTrucksFinders

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :food_trucks_finder, list_food_trucks_finder())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Food trucks finders")
    |> assign(:food_trucks_finders, FoodTruckFinder.get_food_trucks_finders!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Food trucks finders")
    |> assign(:food_trucks_finders, %FoodTrucksFinders{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Food trucks finder")
    |> assign(:food_trucks_finders, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    food_trucks_finders = FoodTruckFinder.get_food_trucks_finders!(id)
    {:ok, _} = FoodTruckFinder.delete_food_trucks_finders(food_trucks_finders)

    {:noreply, assign(socket, :food_trucks_finder, list_food_trucks_finder())}
  end

  defp list_food_trucks_finder do
    FoodTruckFinder.list_food_trucks_finder()
  end
end
