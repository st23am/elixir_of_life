defmodule Life.Generation do
  def run(map, generation) do
    gen = generation + 1
    cells = Life.Map.cells(map)
    cell_diffs = Enum.map(cells, &(Life.Rule.apply_rules(map, &1)))
    next_map = Life.Map.evolve(cell_diffs, map)
    IO.puts "Generation: #{gen} \n"
    string_map = Life.Map.to_map_string(next_map)
    IO.puts string_map
    :timer.sleep 1000
    run(next_map, gen)
  end
end