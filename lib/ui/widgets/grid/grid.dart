import 'package:flutter/material.dart';

import 'package:webspark_test/logic/extensions/extensions.dart';
import 'package:webspark_test/logic/models/models.dart';
import 'package:webspark_test/logic/services/a_star.dart';

const _startColor = Color(0xFF64FFDA);
const _endColor = Color(0xFF009688);
const _pathColor = Color(0xFF4CAF50);
const _obstacleColor = Color(0xFF000000);
const _emptyColor = Color(0xFFFFFFFF);

class AppGrid extends StatelessWidget {
  final List<List<Node>> grid;
  final Cell start;
  final Cell end;
  final List<Cell> path;
  final Color startColor;
  final Color endColor;
  final Color pathColor;
  final Color obstacleColor;
  final Color emptyColor;

  const AppGrid({
    super.key,
    required this.grid,
    required this.start,
    required this.end,
    required this.path,
    this.startColor = _startColor,
    this.endColor = _endColor,
    this.pathColor = _pathColor,
    this.obstacleColor = _obstacleColor,
    this.emptyColor = _emptyColor,
  });

  @override
  Widget build(BuildContext context) {
    var coordinateAxis = grid.asMap().keys.toList();

    return Table(
      border: TableBorder.all(),
      children: coordinateAxis
          .map(
            (row) => TableRow(
              children: coordinateAxis
                  .map(
                    (cell) => TableCell(
                      child: Container(
                        height: context.screen.width / coordinateAxis.length,
                        decoration: BoxDecoration(
                          color: _getColorCell(grid[row][cell]),
                        ),
                        child: Center(
                          child: Text(
                            '(${grid[row][cell].x}, ${grid[row][cell].y})',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: grid[row][cell].isObstacle ? emptyColor : obstacleColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Color _getColorCell(Node node) {
    if (node.isObstacle) return obstacleColor;
    if (node.x == start.x && node.y == start.y) return startColor;
    if (node.x == end.x && node.y == end.y) return endColor;
    if (path.firstWhereOrNull((cell) => cell.x == node.x && cell.y == node.y) != null) {
      return pathColor;
    }
    return emptyColor;
  }
}
