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
    throw "Error!!! should never happen";
  }

  double _sum() => keys.reduce((a, c) => a + c);
}
