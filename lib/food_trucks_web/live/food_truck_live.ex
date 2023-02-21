defmodule FoodTrucksWeb.FoodTrucksLive do
  use FoodTrucksWeb, :live_view

  NimbleCSV.define(MyParser, separator: ",", escape: "\"", line_separator: "\r\n")

  @line_headers [
    :locationid,
    :applicant,
    :FacilityType,
    :cnn,
    :LocationDescription,
    :address,
    :blocklot,
    :block,
    :lot,
    :permit,
    :Status,
    :FoodItems,
    :X,
    :Y,
    :latitude,
    :longitude,
    :Schedule,
    :dayshours,
    :NOISent,
    :Approved,
    :Received,
    :PriorPermit,
    :ExpirationDate,
    :Location,
    :"Fire Prevention Districts",
    :"Police Districts",
    :"Supervisor Districts",
    :"Zip Codes",
    :"Neighborhoods (old)"
  ]

  def mount(_params, _session, socket) do
    food_trucks =
      "priv/data/Mobile_Food_Facility_Permit.csv"
      |> File.stream!(read_ahead: 100_000)
      |> MyParser.parse_stream()
      |> Stream.map(&format_line/1)

    {:ok,
     socket
     |> assign(:food_trucks, food_trucks)
     |> assign(:results, nil)}
  end

  @spec format_line(list()) :: map()
  def format_line(row) do
    row
    |> Stream.zip_with(@line_headers, &{&2, &1})
    |> Enum.into(%{})
  end

  def handle_event("search", %{"lat" => lat, "long" => long, "radius" => radius}, socket) do
    results = search(socket.assigns.food_trucks, lat, long, radius)
    {:noreply, assign(socket, :results, results)}
  end

  def search(food_trucks, lat, long, radius) do
    food_trucks
    |> Enum.filter(fn %{latitude: lat2, longitude: long2} ->
      {eradius, ""} = Float.parse(radius)
      calculate(lat, lat2, long, long2)
      calculate(lat, lat2, long, long2) <= eradius
    end)
  end

  defp calculate(lat, lat2, long, long2) do
    {lat2, ""} = Float.parse(lat2)
    {lat, ""} = Float.parse(lat)
    {long2, ""} = Float.parse(long2)
    {long, ""} = Float.parse(long)

    dlat = to_radians(lat2 - lat)
    dlon = to_radians(long2 - long)

    a =
      :math.sin(dlat / 2) * :math.sin(dlat / 2) +
        :math.cos(to_radians(lat)) * :math.cos(to_radians(lat2)) *
          :math.sin(dlon / 2) * :math.sin(dlon / 2)

    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1 - a))

    6371.0 * c
  end

  defp to_radians(degrees) do
    degrees * :math.pi() / 180
  end

  def render(assigns) do
    food_trucks = assigns.food_trucks

    ~L"""
    <form phx-submit="search">
      <label for="lat">Latitude:</label>
      <input type="text" name="lat" id="lat">
      <label for="long">Longitude:</label>
      <input type="text" name="long" id="long">
      <label for="radius">Radius (in meters):</label>
      <input type="text" name="radius" id="radius">
      <button type="submit">Search</button>
    </form>
    <ul>
    <%= if @results do %>
      <%= for result <- @results do %>
        <li><%= result.applicant %></li>
      <% end %>
    <% end %>
    </ul>
    <h1>Food Trucks in San Francisco</h1>
    <table>
      <thead>
        <tr>
          <th>Truck Name</th>
          <th>Address</th>
          <th>Latitude</th>
          <th>Longitude</th>
        </tr>
      </thead>
      <tbody>
        <%= for truck <- food_trucks do %>
          <tr>
            <td><%= truck.applicant %></td>
            <td><%= truck.address %></td>
            <td><%= truck.latitude %></td>
            <td><%= truck.longitude %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end
