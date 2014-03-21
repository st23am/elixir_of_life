defmodule Life.Rule do
  import Life.Map

  def apply_rules(map, cell) do
    living_neighbors = Life.Map.neighbors_for_cell(map, cell.location) |> count_living_cells
    cond do
      living_neighbors < 2 ->
        apply_under_population(cell)

      living_neighbors > 3 ->
        apply_over_population( cell)

      living_neighbors == 3 and cell.state == "D" ->
        apply_reproduction(cell)

      living_neighbors >= 2 and living_neighbors <= 3 ->
        Life.Map.CellDiff.new(location: cell.location,
                              previous_state: cell.previous_state,
                              current_state: cell.state,
                              next_state: "L")
    end
  end

  def apply_under_population(cell) do
    Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: "D")
  end

  def apply_over_population(cell) do
    Life.Map.CellDiff.new(location: cell.location,
                            previous_state: cell.previous_state,
                            current_state: cell.state,
                            next_state: "D")
  end

  def apply_reproduction(cell) do
    Life.Map.CellDiff.new(location: cell.location,
                          previous_state: cell.previous_state,
                          current_state: cell.state,
                          next_state: "L")
  end

  def count_living_cells(cells) do
    Enum.map(cells, &(&1.state))
    |> Enum.count(&(&1 == "L"))
  end
end