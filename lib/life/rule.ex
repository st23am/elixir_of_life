defmodule Life.Rule do
  import Life.Map

  def apply_under_population(map, cell) do
    neighbors = Life.Map.neighbors_for_cell(map, cell.location)
    if count_living_cells(neighbors) < 2 do
      Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: "D")
    else
      Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: cell.state)
    end
  end

  def apply_over_population(map, cell) do
    neighbors = Life.Map.neighbors_for_cell(map, cell.location)
    if count_living_cells(neighbors) > 3 do
      Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: "D")
    else
      Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: cell.state)
    end
  end

  def apply_reproduction(map, cell) do
    neighbors = Life.Map.neighbors_for_cell(map, cell.location)
    if count_living_cells(neighbors) == 3 && cell.state == "D" do
      Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: "L")
    else
      Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: cell.state)
    end
  end

  def count_living_cells(cells) do
    Enum.map(cells, &(&1.state))
    |> Enum.count(&(&1 == "L"))
  end
end