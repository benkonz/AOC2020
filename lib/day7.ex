defmodule AOC.Day7 do
  defmodule Graph do
    def new() do
      Map.new()
    end

    def add_node(graph, node) do
      if Map.has_key?(graph, node) do
        graph
      else
        Map.put(graph, node, [])
      end
    end

    def add_edge(graph, src, dst, weight) do
      Map.get_and_update(graph, src, fn children ->
        if children == nil do
          {children, [[weight, dst]]}
        else
          {children, [[weight, dst] | children]}
        end
      end)
      |> elem(1)
    end

    def get_nodes(graph) do
      Map.keys(graph)
    end

    def get_children(graph, node) do
      Map.get(graph, node)
    end
  end

  def parse_input(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce(Graph.new(), fn line, graph ->
      regex = ~r/^(.*) bags contain (.*)\.$/
      [_str, source_node, children_nodes_str] = Regex.run(regex, line)
      children_nodes = parse_children_nodes(children_nodes_str)

      graph = Graph.add_node(graph, source_node)

      children_nodes
      |> Enum.reduce(graph, fn [weight, node], graph ->
        graph = Graph.add_node(graph, node)
        Graph.add_edge(graph, source_node, node, weight)
      end)
    end)
  end

  def parse_children_nodes(children_nodes_str) do
    if children_nodes_str == "no other bags" do
      []
    else
      String.split(children_nodes_str, ", ")
      |> Enum.map(fn node_str ->
        regex = ~r/^([[:digit:]]) (.*) (bag|bags)$/
        [_str, weight, node, _bag] = Regex.run(regex, node_str)
        [String.to_integer(weight), node]
      end)
    end
  end

  def traverse_part1(graph, node, target, visited) do
    if graph == nil || node == nil || MapSet.member?(visited, node) do
      false
    else
      visited = MapSet.put(visited, node)

      if node == target do
        true
      else
        Graph.get_children(graph, node)
        |> Enum.reduce(false, fn [_weight, node], acc ->
          acc || traverse_part1(graph, node, target, visited)
        end)
      end
    end
  end

  def part1(graph) do
    # for each node, traverse the graph until we either explore all nodes, or find a "shiny gold" bag
    Graph.get_nodes(graph)
    |> Enum.reduce(0, fn node, acc ->
      if node == "shiny gold" do
        acc
      else
        result = traverse_part1(graph, node, "shiny gold", MapSet.new())
        if result, do: acc + 1, else: acc
      end
    end)
  end

  def traverse_part2(graph, node, visited) do
    if graph == nil || node == nil || MapSet.member?(visited, node) do
      0
    else
      visited = MapSet.put(visited, node)

      Graph.get_children(graph, node)
      |> Enum.reduce(0, fn [weight, node], acc ->
        acc + weight + weight * traverse_part2(graph, node, visited)
      end)
    end
  end

  def part2(graph) do
    traverse_part2(graph, "shiny gold", MapSet.new())
  end
end
