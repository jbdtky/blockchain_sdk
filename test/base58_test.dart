import 'dart:convert';

import 'package:blockchain_sdk/src/utils/base58.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Base58', () {
    expect(Base58.encode(ascii.encode('Hello World!')), '2NEpo7TZRRrLZSi2U');
    expect(
        Base58.encode(
            ascii.encode('The quick brown fox jumps over the lazy dog.')),
        'USm3fpXnKG5EUBx2ndxBDMPVciP5hGey2Jh4NDv6gmeo1LkMeiKrLJUUBk6Z');
  });
}
