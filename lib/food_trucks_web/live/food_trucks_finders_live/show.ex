defmodule FoodTrucksWeb.FoodTrucksFindersLive.Show do
  use FoodTrucksWeb, :live_view

  alias FoodTrucks.FoodTruckFinder

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:food_trucks_finders, FoodTruckFinder.get_food_trucks_finders!(id))}
  end

  defp page_title(:show), do: "Show Food trucks finders"
  defp page_title(:edit), do: "Edit Food trucks finders"
end
