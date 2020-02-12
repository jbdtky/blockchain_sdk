import 'dart:convert';
import 'dart:io';

import 'package:blockchain_sdk/blockchain_sdk.dart';
import 'package:blockchain_sdk/src/bip39/wordlist.dart';
import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('English word list', () {
    expect(WordList.english.length, 2048);
  });

  test('Generate a 12 words mnemonic', () {
    final mnemonic = Mnemonic.generate();
    expect(mnemonic.words.length, 12);
  });

  test('Generate a 15 words mnemonic', () {
    final mnemonic = Mnemonic.generate(length: 15);
    expect(mnemonic.words.length, 15);
  });

  test('Generate a 18 words mnemonic', () {
    final mnemonic = Mnemonic.generate(length: 18);
    expect(mnemonic.words.length, 18);
  });

  test('Generate a 21 words mnemonic', () {
    final mnemonic = Mnemonic.generate(length: 21);
    expect(mnemonic.words.length, 21);
  });

  test('Generate a 24 words mnemonic', () {
    final mnemonic = Mnemonic.generate(length: 24);
    expect(mnemonic.words.length, 24);
  });

  test('Mnemonic to seed', () async {
    final data = await File('test/assets/mnemonic_data.json').readAsString();
    final List<dynamic> json = jsonDecode(data);

    json.forEach((testData) {
      final words = testData[1].split(' ');
      final expectSeed = testData[2];
      final mnemonic = Mnemonic(words);
      expect(hex.encode(mnemonic.toSeed(passphrase: 'TREZOR')), expectSeed);
    });
  });

  test('Mnemonic to seed in README', () {
    final words = [
      'bind',
      'assume',
      'arrange',
      'apology',
      'around',
      'admit',
      'barrel',
      'alpha',
      'bird',
      'basket',
      'baby',
      'apology'
    ];
    final mnemonic = Mnemonic(words);
    final seed = mnemonic.toSeed();
    final seedWithPassphrase = mnemonic.toSeed(passphrase: 'passphrase');
    expect(hex.encode(seed),
        'bcd46f78ee88e56a30fe102095ce3999d48631afbf32df302af39b98e7047d77174541eb3d44a717dd2824fdda1218d12f86e5d8ab1d54a131db206bbb64d959');
    expect(hex.encode(seedWithPassphrase),
        '886010b4aa1f7c70001f23a586ab0ab7db189dce6748f0b57d7d08059052e9ffa336c834002b3934cc03fdfac1143fa931b01531980a93a27a181d72e60577eb');
  });
}
