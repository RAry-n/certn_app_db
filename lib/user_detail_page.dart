import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
const String masterKey = 'z9N2rJe5SmdMNuTfG56GkHUtEydFBQVOVHhHdKX2r4k=';
class UserDetailsPage extends StatelessWidget {
  final UserProfile userProfile;

  const UserDetailsPage({super.key, required this.userProfile});

  // Example master key (store this securely)


// Function to concatenate keys, decrypt and validate authorization
  String generateSecureKey(String appKey, String userKey) {
    String concatenatedKey = appKey + userKey;

    // Decrypt using the master key (in this case, we use HMAC for demo purposes)
    var hmacSha256 = Hmac(sha256, utf8.encode(masterKey));
    var digest = hmacSha256.convert(utf8.encode(concatenatedKey));

    return digest.toString();
  }

// Function to validate the key (e.g., match it with a stored value)
  bool validateUserAccess(String secureKey, String storedKey) {
    return secureKey == storedKey;
  }

  Future<bool> authorizeUser(String uid, String appKey) async {
    // Retrieve the user profile from Firebase
    final dbref = FirebaseDatabase.instance.ref('profile/$uid');
    final snapshot = await dbref.get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);

      // Extract the stored appKey and userKey from Firebase
      String storedAppKey = userData['appKey'];
      String userKey = userData['userKey'];

      // Concatenate appKey and userKey and generate the secure key
      String secureKey = generateSecureKey(appKey, userKey);

      // Now validate the secure key (compare with the stored key if applicable)
      return validateUserAccess(secureKey, storedAppKey);  // Assuming some validation logic
    } else {
      return false; // User data not found
    }
  }


  Future<String> getAppKey() async {
    final prefs = await SharedPreferences.getInstance();
    String? appKey = prefs.getString('appKey');

    // If appKey does not exist, generate and save a new one
    if (appKey == null) {
      appKey = _generateAppKey();
      await prefs.setString('appKey', appKey);
    }

    return appKey;
  }
  String _generateAppKey() {
    // Generate a random app key (for example, 16-character alphanumeric key)
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random.secure();
    return String.fromCharCodes(Iterable.generate(16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: getAppKey(), // Get the app key of the current device
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        String appKey = snapshot.data!;  // Current app key
        String uid = FirebaseAuth.instance.currentUser!.uid;  // Current user ID

        return FutureBuilder(
          future: authorizeUser(uid, appKey),
          builder: (context, AsyncSnapshot<bool> authSnapshot) {
            if (!authSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            bool isAuthorized = authSnapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text(userProfile.name),
              ),
              body: isAuthorized
                  ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shop Name: ${userProfile.shopName}'),
                    Text('Merchant ID: ${userProfile.merchantID}'),
                    Text('Shop Address: ${userProfile.shopAddress}'),
                  ],
                ),
              )
                  : const Center(
                child: Text('Access Denied!'),
              ),
            );
          },
        );
      },
    );
  }
}
