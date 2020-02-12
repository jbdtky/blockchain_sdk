import 'dart:typed_data';

class Base58 {
  static final alphabet =
      '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

  static String encode(Uint8List data) {
    final bytes = <int>[0];

    for (var i = 0; i < data.length; i++) {
      var carry = data[i];

      for (var j = 0; j < bytes.length; j++) {
        carry += bytes[j] << 8;
        bytes[j] = carry % 58;
        carry ~/= 58;
      }

      while (carry > 0) {
        bytes.add(carry % 58);
        carry ~/= 58;
      }
    }

    return bytes.reversed.map((byte) => alphabet[byte]).join('');
  }
}
