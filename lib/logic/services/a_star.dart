class Node {
  final int x;
  final int y;
  bool isObstacle;
  double gScore;
  double fScore;
  Node? cameFrom;

  Node(
    this.x,
    this.y, {
    this.isObstacle = false,
    this.gScore = double.infinity,
    this.fScore = double.infinity,
  });

  bool compare(Node node) => x == node.x && y == node.y;

  double heuristicCostEstimate(Node goal) {
    return ((x - goal.x).abs() + (y - goal.y).abs()).toDouble();
  }
}

class AStar {
  final List<List<Node>> grid;
  final Node start;
  final Node goal;

  AStar({
    required this.grid,
    required this.start,
    required this.goal,
  }) : assert(grid.length > 1 && grid.length < 100);

  List<Node> findPath() {
    var openSet = <Node>[start];
    var closedSet = <Node>[];

    start.gScore = 0;
    start.fScore = start.heuristicCostEstimate(goal);

    while (openSet.isNotEmpty) {
      var current = openSet.reduce((a, b) => a.fScore < b.fScore ? a : b);

      if (current.compare(goal)) {
        return _getPath(current);
      }

      openSet.remove(current);
      closedSet.add(current);

      var neighbors = _getNeighbors(current);

      for (var neighbor in neighbors) {
        final closedSetIsNeighbor =
            closedSet.where((node) => node.x == neighbor.x && node.y == neighbor.y);
        if (closedSetIsNeighbor.isNotEmpty || neighbor.isObstacle) {
          continue;
        }

        var tentativeGScore = current.gScore + 1;

        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
        } else if (tentativeGScore >= neighbor.gScore) {
          continue;
        }

        neighbor.cameFrom = current;
        neighbor.gScore = tentativeGScore;
        neighbor.fScore = neighbor.gScore + neighbor.heuristicCostEstimate(goal);
      }
    }

    return [];
  }

  List<Node> _getPath(Node current) {
    var totalPath = <Node>[current];
    while (current.cameFrom != null) {
      current = current.cameFrom!;
      totalPath.insert(0, current);
    }
    return totalPath;
  }

  List<Node> _getNeighbors(Node node) {
    var neighbors = <Node>[];
    for (var y = -1; y < 2; y++) {
      for (var x = -1; x < 2; x++) {
        if (x == 0 && y == 0) continue;
        final nx = node.x + x;
        final ny = node.y + y;

        if (nx < 0 || nx > grid.length - 1 || ny < 0 || ny > grid[0].length - 1) continue;

        neighbors.add(grid[ny][nx]);
      }
    }
    return neighbors;
  }
}
