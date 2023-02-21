defmodule FoodTrucksWeb.FoodTrucksFindersLive.FormComponent do
  use FoodTrucksWeb, :live_component

  alias FoodTrucks.FoodTruckFinder

  @impl true
  def update(%{food_trucks_finders: food_trucks_finders} = assigns, socket) do
    changeset = FoodTruckFinder.change_food_trucks_finders(food_trucks_finders)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"food_trucks_finders" => food_trucks_finders_params}, socket) do
    changeset =
      socket.assigns.food_trucks_finders
      |> FoodTruckFinder.change_food_trucks_finders(food_trucks_finders_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"food_trucks_finders" => food_trucks_finders_params}, socket) do
    save_food_trucks_finders(socket, socket.assigns.action, food_trucks_finders_params)
  end

  defp save_food_trucks_finders(socket, :edit, food_trucks_finders_params) do
    case FoodTruckFinder.update_food_trucks_finders(socket.assigns.food_trucks_finders, food_trucks_finders_params) do
      {:ok, _food_trucks_finders} ->
        {:noreply,
         socket
         |> put_flash(:info, "Food trucks finders updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_food_trucks_finders(socket, :new, food_trucks_finders_params) do
    case FoodTruckFinder.create_food_trucks_finders(food_trucks_finders_params) do
      {:ok, _food_trucks_finders} ->
        {:noreply,
         socket
         |> put_flash(:info, "Food trucks finders created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
