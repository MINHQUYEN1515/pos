import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';

class SecurityUtils {
  SecurityUtils._();
  static Encrypted encrypt(String plainText, String keyText) {
    if (keyText.isEmpty) {}
    final key = Key.fromUtf8(keyText);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted;
  }

  static String decrypted(Encrypted encrypted, String keyText) {
    if (keyText.isEmpty) return '';
    final key = Key.fromUtf8(keyText);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }

  static generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
