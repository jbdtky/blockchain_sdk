# Blockchain SDK
[![Build Status](https://travis-ci.com/jbdtky/blockchain_sdk.svg?branch=master)](https://travis-ci.com/jbdtky/blockchain_sdk)
[![codecov](https://codecov.io/gh/jbdtky/blockchain_sdk/branch/master/graph/badge.svg)](https://codecov.io/gh/jbdtky/blockchain_sdk)
![version](https://img.shields.io/badge/version-0.1.0-black.svg) 
![compatibility](https://img.shields.io/badge/dart_sdk-+2.6.0-orange.svg) 
![license](https://img.shields.io/badge/license-Apache_2.0-lightgrey.svg) 

<pre>
  Summary: A dart package used for blockchain related project
  Author: Jean-Baptiste Dominguez (twitter/github: @jbdtky)
</pre>

## BIP39

### Mnemonic, Seed

The mnemonic generation is the beginning for a blockchain application. It will create a user-friendly deterministic seed that your user could store easily anywhere. This seed could be used to generate a deterministic key pair in order to sign anything that your would like.

#### Example

```dart
  final mnemonic = Mnemonic.generate();
  print(mnemonic.words) // [bind, assume, arrange, apology, around, admit, barrel, alpha, bird, basket, baby, apology]

  final mnemonic = Mnemonic.generate({words: 24}); // Max entropy = 256
  print(mnemonic.words) // [busy, abuse, among, afraid, bronze, business, adult, awkward, advance, advance, aisle, bench, build, adapt, black, brand, all, bottom, badge, already, ball, burden, alarm, bag]

  final words = ['bind', 'assume', 'arrange', 'apology', 'around', 'admit', 'barrel', 'alpha', 'bird', 'basket', 'baby', 'apology'];
  final mnemonic = Mnemonic(words);

  // Generate the seed from the mnemonic using PBKDF2 with HMAC-SHA512 + 2048 iteration + 64 derivation key length in byte
  final seed = mnemonic.toSeed();
  final seedWithPassphrase = mnemonic.toSeed(passphrase: 'passphrase');
  print(hex.encode(seed)); // bcd46f78ee88e56a30fe102095ce3999d48631afbf32df302af39b98e7047d77174541eb3d44a717dd2824fdda1218d12f86e5d8ab1d54a131db206bbb64d959
  print(hex.encode(seedWithPassphrase)); // 886010b4aa1f7c70001f23a586ab0ab7db189dce6748f0b57d7d08059052e9ffa336c834002b3934cc03fdfac1143fa931b01531980a93a27a181d72e60577eb
```

#### Reference
https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki