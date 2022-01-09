import 'dart:math';

import 'model/bar.dart';

class Solver {
  List<int>? availableLengths;

  Solver(this.availableLengths);

  List<Bar> solve(List<int> desiredLengths) {
    List<Bar> results = [];

    int maxAvailableLength = availableLengths!.reduce(max);

    if (desiredLengths.reduce(max) <= maxAvailableLength) {
      for (var item in desiredLengths) {
        var v = results.where((bar) => bar.remaining()! >= item);
        if (v.isEmpty) {
          results.add(Bar(maxAvailableLength));
        }
        var availableBar =
            results.firstWhere((bar) => bar.remaining()! >= item);

        availableBar.cut(item);
      }

      for (var bar in results) {
        var length = bar.originalLength;
        for (var availableLength in availableLengths!) {
          if (availableLength != bar.originalLength &&
              bar.originalLength! - bar.remaining()! <= availableLength) {
            length = availableLength;
            break;
          }
        }
        bar.originalLength = length;
      }
    }

    return results;
  }
}
