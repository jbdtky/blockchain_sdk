# Blockchain SDK

<pre>
  Summary: A dart package used for blockchain related project
  Author: Jean-Baptiste Dominguez (twitter/github: @jbdtky)
  Created: 2020-02-11
</pre>

## BIP39

### Mnemonic

The mnemonic generation is the beginning for a blockchain application. It will create a user-friendly deterministic seed that your user could store easily anywhere. This seed could be used to generate a deterministic key pair in order to sign anything that your would like.

#### Example

```dart
  final mnemonic = Mnemonic.generate();
  // [bind, assume, arrange, apology, around, admit, barrel, alpha, bird, basket, baby, apology]

  final mnemonic = Mnemonic.generate({words: 24}); // Max entropy = 256
  // [busy, abuse, among, afraid, bronze, business, adult, awkward, advance, advance, aisle, bench, build, adapt, black, brand, all, bottom, badge, already, ball, burden, alarm, bag]

```

#### Reference
https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki