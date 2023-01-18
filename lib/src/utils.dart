import 'dart:io';
import 'dart:math';

Random rng = Random();
double randomDouble() => rng.nextDouble();
int randomInt(int min, int max) => rng.nextInt(max - min) + min;

extension RandomElement<T> on List<T> {
  T randomElement() {
    return this[randomInt(0, length)];
  }
}

extension RandomRoll<T> on Map<double, T> {
  T randomElement() {
    final r = randomDouble() * _sum();
    var s = 0.0;
    for (var k in keys) {
      s += k;
      if (r < s) {
        return this[k]!;
      }
    }
    throw "should never happen";
  }

  double _sum() => keys.reduce((a, c) => a + c);
}

Future<void> waitMS(int ms) async {
  await Future.delayed(Duration(milliseconds: ms));
}

class MultiSet<T extends Comparable> {
  Map<T, int> multiSet = {};

  void add(T t) {
    if (multiSet.containsKey(t)) {
      multiSet[t] = multiSet[t]! + 1;
    } else {
      multiSet[t] = 1;
    }
  }

  void addAll(Iterable<T> ts) {
    for (final t in ts) {
      add(t);
    }
  }

  remove(T t) {
    if (multiSet.containsKey(t)) {
      int prevVal = multiSet[t]!;
      if (prevVal <= 1) {
        multiSet.remove(t);
      } else {
        multiSet[t] = prevVal - 1;
      }
    }
  }

  List<MapEntry<T, int>> toList() {
    var list = multiSet.entries.toList();
    list.sort((a, b) => a.key.compareTo(b.key));
    return list;
  }
}
