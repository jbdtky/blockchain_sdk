import 'dart:typed_data';

extension Uint8ListExtensions on Uint8List {
  String toBinary() {
    return this
        .map((byte) => byte
                .toRadixString(2) // Convert byte to binary
                .padLeft(8, '0') // Make sure it is 8
            )
        .join('');
  }

  // TODO: Implement the case if the length is different
  Uint8List xor(Uint8List b) {
    if (this.length != b.length) {
      throw ArgumentError.value("It should have the same length");
    }

    Uint8List c = Uint8List(this.length);
    for (var i = 0; i < this.length; i++) {
      c[i] = this.elementAt(i) ^ b.elementAt(i);
    }
    return c;
  }
}
