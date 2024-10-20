// import 'dart:convert';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// class EncryptionHelper {
//   // Define a key and an initialization vector (IV) for AES
//   final key = encrypt.Key.fromUtf8('6Y9a1H+F1QWyI4tM4iM4yA=='); // 32 chars
//   final iv = encrypt.IV.fromLength(16); // AES uses a 16-byte IV
//
//   // Encrypt the data
//   String encryptData(String data) {
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final encrypted = encrypter.encrypt(data, iv: iv);
//     return encrypted.base64;  // Encrypted data in base64 format
//   }
//
//   // Decrypt the data
//   String decryptData(String encryptedData) {
//     final encrypter = encrypt.Encrypter(encrypt.AES(key));
//     final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
//     return decrypted;  // Return the decrypted data as a string
//   }
// }

import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  // Base64 encoded 256-bit key and 16-byte IV
  // final Key key = Key.fromBase64("6Y9a1H+F1QWyI4tM4iM4yA==");
  // final IV iv = IV.fromBase64("r8e6b5P9FzFJkkQR7P20Hg==");
  // final key = Key.fromUtf8('abcdefghijklmnopqrstuvwxyzabcdef');
  final key = encrypt.Key.fromUtf8('b8cc8e559b5915ad4a61c0414f901788');
  final iv = encrypt.IV.fromLength(16);

  // Method to encrypt data
  /*String encryptData(String data) {
    try{
     // final encrypter = Encrypter(AES(key));
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(data, iv: iv);
      print("encrypted: "+encrypted.base16);
      // String str  = encrypted.base16;
      // print("decrypted "+encrypter.decrypt(Encrypted.fromBase16(str),iv: iv));
      return encrypted.base16;
    } // Return the encrypted data as a Base64 string
    catch(e)
    {
      print("Error encrypt: $e");
    }
    return "";
  }

  // Method to decrypt data
  String decryptData(String encryptedData) {
    try{
     // final encrypter = Encrypter(AES(key));
      final encrypter = Encrypter(AES(key));
      final decrypted = encrypter.decrypt(Encrypted.fromBase16(encryptedData),
          iv: iv); // Decrypt the Base64 encoded data
      return decrypted;
    }
    catch(e)
    {
      print("error decrypt $e");
    }
    return "";// Return the decrypted plain text
  }*/

  // String encryptData(String data) {
  //   String en = ""; // Initialize the encrypted string
  //   for (var c in data.codeUnits) { // Iterate over the Unicode code units of the string
  //     en += String.fromCharCode(c + 2); // Shift each character by 2 and convert back to a character
  //   }
  //   return en; // Return the encrypted string
  // }
  //
  // String decryptData(String data) {
  //   String en = ""; // Initialize the encrypted string
  //   for (var c in data.codeUnits) { // Iterate over the Unicode code units of the string
  //     en += String.fromCharCode(c -2); // Shift each character by 2 and convert back to a character
  //   }
  //   return en; // Return the encrypted string
  // }

  // Method to encrypt data
  String encryptData(String plainText) {
    try{
      if (key == null) {
        throw Exception('Encryption key is not initialized.');
      }
      final iv = encrypt.IV.fromLength(16); // Generate a random IV
      final encrypter =
          encrypt.Encrypter(encrypt.AES(key!, mode: encrypt.AESMode.cbc));

      final encrypted = encrypter.encrypt(plainText, iv: iv);
      final ivBase64 = iv.base64;
      final encryptedBase64 = encrypted.base64;
      print('$ivBase64:$encryptedBase64');
      return '$ivBase64:$encryptedBase64';
    }
    catch(e)
    {
      print("encryption: $e");
    }
    return 'lol'; // Store IV and ciphertext together
  }

  // Method to decrypt data
  String decryptData(String encryptedData) {
    try{
      if (key == null) {
        throw Exception('Encryption key is not initialized.');
      }
      final parts = encryptedData.split(':');
      final iv = encrypt.IV.fromBase64(parts[0]); // Extract the IV
      final encrypted = encrypt.Encrypted.fromBase64(parts[1]);

      final encrypter =
          encrypt.Encrypter(encrypt.AES(key!, mode: encrypt.AESMode.cbc));
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      print(decrypted);
      return decrypted;
    }
    catch(e)
    {
      print("decryption: $e");
    }
    return 'lol';
  }

}



