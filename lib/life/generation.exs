defmodule Life.Generation do
  def run(map, generation) do
    gen = generation + 1
    cells = Life.Map.cells(map)
    cell_diffs = Enum.map(cells, &(Life.Rule.apply_rules(map, &1)))
    next_map = Life.Map.evolve(cell_diffs, map)
    :timer.sleep 200
    IO.write("\e[H\e[2J")
    string_map = Life.Map.to_map_string(next_map)
    IO.write string_map
    IO.write "Generation: #{gen} \n"
    run(next_map, gen)
  end
end