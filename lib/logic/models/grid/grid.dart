import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webspark_test/logic/models/models.dart';
import 'package:webspark_test/logic/services/services.dart';

part 'grid.freezed.dart';
part 'grid.g.dart';

@freezed
class Grid with _$Grid {
  const Grid._();

  const factory Grid({
    required String id,
    required List<String> field,
    required Cell start,
    required Cell end,
  }) = _Grid;

  List<List<String>> get fieldGrid => field.map((e) => e.split('').toList()).toList();

  List<List<Node>> get getGrid {
    var grid = <List<Node>>[];
    for (var y = 0; y < fieldGrid.length; y++) {
      var row = <Node>[];
      for (var x = 0; x < fieldGrid[y].length; x++) {
        row.add(Node(x, y, isObstacle: fieldGrid[y][x] == 'X'));
      }
      grid.add(row);
    }

    return grid;
  }

  factory Grid.fromJson(Map<String, Object?> json) => _$GridFromJson(json);
}
