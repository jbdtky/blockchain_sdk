

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:blockchain_sdk/src/utils/uint8list_extensions.dart';

class PBKDF2 {
  final Hash hash;
  String password;
  String salt;
  int iteration;
  int length;

  PBKDF2(this.hash, {this.password = '', this.salt = '', this.iteration = 2048, this.length = 64});

  Uint8List process() {

    // Ti = F(Password, Salt, c, i)
    List<int> t = <int>[];

    for (var i = 1;; i++) {
      t..addAll(List.from(_f(i)));

      if (t.length >= length) {
        break;
      }
    }

    return Uint8List.fromList(t.sublist(0, length));
  }

  // 0000 0000
  // 1 octet = 8 bits
  // 1 hex = 2 octets

  /// Calculate 0 to iteration for a block
  Uint8List _f(int i) {

    // F(Password, Salt, c, i) = U1 ^ U2 ^ ... ^ Uc
    var key = utf8.encode(password);
    final hmac = Hmac(hash, key); // Setup hmac with the key

    // Calculate the first block
    // U1 = PRF(Password, Salt || INT_32_BE(1)) 
    var message = utf8.encode(salt)
      + i.toRadixString(8)
        .padLeft(4, '0')
        .split('')
        .map((num) => int.parse(num, radix: 8))
        .toList(); // concatenate salt + i

    Uint8List u = Uint8List.fromList(hmac.convert(message).bytes);
    Uint8List v = u;
    for (var j = 1; j < iteration; j++) { // Calculate the other blocks
      // Ui = PRF(Password, Ui-1) 
      u = Uint8List.fromList(hmac.convert(u).bytes);
      v = v.xor(u);
    }

    return v;
  }
}