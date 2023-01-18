import 'dart:io';

import 'package:dart_console/dart_console.dart';

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
  48: KeyCode.n0,
  38: KeyCode.up,
  40: KeyCode.down,
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
  up,
  down,
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

const ATTACK_KEY = KeyCode.w;
const ESCAPE_KEY = KeyCode.s;
const UP_KEY = KeyCode.w;
const DOWN_KEY = KeyCode.s;
const ACCEPT_KEY = KeyCode.e;
const CLOSE_KEY = KeyCode.q;
const CONTINUE_KEY = KeyCode.space;
const SEARCH_KEY = KeyCode.s;
const CHARACTER_KEY = KeyCode.e;
const INVENTORY_KEY = KeyCode.d;
