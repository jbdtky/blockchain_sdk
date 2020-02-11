

import 'dart:math';
import 'dart:typed_data';

import 'package:blockchain_sdk/src/bip39/wordlist.dart';
import 'package:crypto/crypto.dart';

class Mnemonic {

  /// Formula
  /// ENT = 128
  /// CS = ENT / 32
  /// MS = (ENT + CS) / 11
  static List<String> generate({int words = 12}) {
    if(words % 3 != 0 && words >= 12 && words <= 32) {
      throw Exception('The words must be 12, 15, 18, 21 or 24');
    }

    final int entropySize = words~/3*32 // In bits
      ~/8; // In byte

    final random = Random.secure();
    var entropy = Uint8List(entropySize);

    for (var i = 0; i < entropySize; i++) {
      entropy[i] = random.nextInt(255);
    }

    List<String> binary = (
      entropy
        .toBinary()
      + _calculateBinaryChecksum(entropy) // add checksum at the end
    ).split(''); // Make it a list

    final length = binary.length~/11;
    final wordIndexes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      wordIndexes[i] = int.parse(binary.sublist(0 + i*11, 11 + i*11).join(''), radix: 2);
    }

    final wordList = WordList.english;
    final mnemonic = wordIndexes
      .map((index) => wordList[index])
      .toList();

    return mnemonic;
  }

  static String _calculateBinaryChecksum(Uint8List data) {
    final checksum = data.length~/4; // 32 / 8 = 4 bits
    final Uint8List hash = sha256.convert(data).bytes;
    return hash
      .toBinary()
      .substring(0, checksum);
  }
}

extension Uint8ListExtensions on Uint8List {
  String toBinary() {
    return this.map((byte) => byte
      .toRadixString(2) // Convert byte to binary
      .padLeft(8, '0') // Make sure it is 8
    ).join('');
  }
}