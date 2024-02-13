import 'dart:convert';
import 'dart:typed_data';

base64DecodeImage(String? imageSrc) {
  if (imageSrc == null || imageSrc.isEmpty) {
    return Uint8List(0);
  }

  return base64.decode(imageSrc.split(',').last);
}
