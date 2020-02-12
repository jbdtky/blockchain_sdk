import 'dart:typed_data';

import 'package:blockchain_sdk/src/utils/base58.dart';
import 'package:blockchain_sdk/src/utils/uint8list_extensions.dart';

/// Reference https://en.bitcoin.it/wiki/Base58Check_encoding#Version_bytes
class Base58Check {
  /// The version should be added before.
  static String encode(Uint8List data) {
    Uint8List hash = data.hash256();
    Uint8List combine = Uint8List.fromList(
        [data, hash.sublist(0, 4)].expand((i) => i).toList());
    return Base58.encode(combine);
  }
}
