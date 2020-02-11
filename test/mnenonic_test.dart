import 'package:blockchain_sdk/blockchain_sdk.dart';
import 'package:blockchain_sdk/src/bip39/wordlist.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('English word list', () {
    expect(WordList.english.length, 2048);
  });

  test('Generate a 12 words mnemonic', () {
    final mnemonic = Mnemonic.generate();
    expect(mnemonic.length, 12);
  });

  test('Generate a 15 words mnemonic', () {
    final mnemonic = Mnemonic.generate(words: 15);
    expect(mnemonic.length, 15);
  });

  test('Generate a 18 words mnemonic', () {
    final mnemonic = Mnemonic.generate(words: 18);
    expect(mnemonic.length, 18);
  });

  test('Generate a 21 words mnemonic', () {
    final mnemonic = Mnemonic.generate(words: 21);
    expect(mnemonic.length, 21);
  });

  test('Generate a 24 words mnemonic', () {
    final mnemonic = Mnemonic.generate(words: 24);
    expect(mnemonic.length, 24);
  });
}
