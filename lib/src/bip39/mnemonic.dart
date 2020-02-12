

import 'dart:math';
import 'dart:typed_data';

import 'package:blockchain_sdk/src/bip39/wordlist.dart';
import 'package:blockchain_sdk/src/utils/pbkdf2.dart';
import 'package:crypto/crypto.dart';
import 'package:blockchain_sdk/src/utils/uint8list_extensions.dart';

class Mnemonic {
  List<String> words;

  // TODO: make sure the wordlist contains these words
  Mnemonic(List<String> words) {
    if(words.length % 3 != 0 && words.length >= 12 && words.length <= 32) {
      throw ArgumentError.value(
          'The words length must be 12, 15, 18, 21 or 24');
    }

    this.words = words;
  }

  /// Generate the seed from the mnemonic and passphrase
  Uint8List toSeed({String passphrase = ''}) {
    final pbkdf2 = PBKDF2(sha512, 
                            password: words.join(' ').trim(), 
                            salt: 'mnemonic' + passphrase, 
                            iteration: 2048, 
                            length: 64);
                            
    return pbkdf2.process();
  }


  /// Formula
  /// ENT = 128
  /// CS = ENT / 32
  /// MS = (ENT + CS) / 11
  static Mnemonic generate({int length = 12}) {
    if(length % 3 != 0 && length >= 12 && length <= 32) {
      throw ArgumentError.value(
          'The length must be 12, 15, 18, 21 or 24');
    }

    final int entropySize = length~/3*32 // In bits
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

    final wordIndexes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      wordIndexes[i] = int.parse(binary.sublist(0 + i*11, 11 + i*11).join(''), radix: 2);
    }

    final wordList = WordList.english;
    final mnemonic = wordIndexes
      .map((index) => wordList[index])
      .toList();

    return Mnemonic(mnemonic);
  }

  static String _calculateBinaryChecksum(Uint8List data) {
    final checksum = data.length~/4; // 32 / 8 = 4 bits
    final Uint8List hash = sha256.convert(data).bytes;
    return hash
      .toBinary()
      .substring(0, checksum);
  }
}