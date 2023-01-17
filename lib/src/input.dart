import 'dart:io';

Map<int, KeyCode> intToKeyCode = {
  27: KeyCode.esc,
  32: KeyCode.space,
  113: KeyCode.q,
  119: KeyCode.w,
  101: KeyCode.e,
  114: KeyCode.r,
  97: KeyCode.a,
  115: KeyCode.s,
  100: KeyCode.d,
  102: KeyCode.f,
  49: KeyCode.n1,
  50: KeyCode.n2,
  51: KeyCode.n3,
  52: KeyCode.n4,
  53: KeyCode.n5,
  54: KeyCode.n6,
  55: KeyCode.n7,
  56: KeyCode.n8,
  57: KeyCode.n9,
  48: KeyCode.n0
};

enum KeyCode {
  esc,
  space,
  q,
  w,
  e,
  r,
  a,
  s,
  d,
  f,
  n1,
  n2,
  n3,
  n4,
  n5,
  n6,
  n7,
  n8,
  n9,
  n0,
}

KeyCode waitForKey() {
  while (true) {
    int byte = stdin.readByteSync();
    KeyCode? code = intToKeyCode[byte];
    if (code != null) {
      return code;
    }
  }
}
