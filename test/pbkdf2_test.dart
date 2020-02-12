import 'package:blockchain_sdk/src/utils/pbkdf2.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('PBKDF2-Hmac-Sha1', () {
    var seed = PBKDF2(sha1, password: 'password', salt: 'salt', iteration: 1, length: 20).process();
    expect(hex.encode(seed), '0c60c80f961f0e71f3a9b524af6012062fe037a6');

    seed = PBKDF2(sha1, password: 'password', salt: 'salt', iteration: 2, length: 20).process();
    expect(hex.encode(seed), 'ea6c014dc72d6f8ccd1ed92ace1d41f0d8de8957');

    seed = PBKDF2(sha1, password: 'passwordPASSWORDpassword', salt: 'saltSALTsaltSALTsaltSALTsaltSALTsalt', iteration: 4096, length: 25).process();
    expect(hex.encode(seed), '3d2eec4fe41c849b80c8d83662c0e44a8b291a964cf2f07038');
  });

  test('PBKDF2-Hmac-Sha512', () {
    var seed = PBKDF2(sha512, password: 'brave ahead betray blush bonus basket budget blur athlete agent build brave', salt: 'mnemonic', iteration: 2048, length: 64).process();
    expect(hex.encode(seed), '44ae4430368ed65e5c95f92dd78b3ef8cd3ce78d0b75c6c9b3a3e2727ecd3186e2133cd10f2bae8549f07fbbbcb0ada52de3fdebe6bb88ceb97ce9934a1298d3');

    seed = PBKDF2(sha512, password: 'brave ahead betray blush bonus basket budget blur athlete agent build brave', salt: 'mnemonic' + 'passphrase', iteration: 2048, length: 64).process();
    expect(hex.encode(seed), '7a6e6c54e6205752fcad2e684154ea29fc5013f2d1ac2d90a2e34a7a07c464c41784eac6e9ab99fd1eb82b176d8adb9990eeed90911c90d500636210be0395ea');
  });
}
