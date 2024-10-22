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

  // Function to generate the secure key by concatenating appKey and userKey
  String generateSecureKey(String appKey, String userKey) {
    String concatenatedKey = appKey + userKey;
    return concatenatedKey;
   // return base64Encode(sha256.convert(utf8.encode(concatenatedKey)).bytes);
  }

  // Function to validate the secure key (checks if it matches the stored key)
  bool validateUserAccess(String secureKey, String storedKey) {
    return secureKey == storedKey;
  }

  // Function to authorize the user
  Future<bool> authorizeUser(String uid) async {
    // Retrieve the appKey from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String? appKey = prefs.getString('appKey');
    String? userKey =FirebaseAuth.instance.currentUser?.uid;

    // Get the user's data from Firebase Realtime Database
    final dbRef = FirebaseDatabase.instance.ref('profile/$uid');
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = Map<String, dynamic>.from(snapshot.value as Map);

      // Extract the stored appKey and userKey from Firebase
      String storedAppKey = userData['appKey']; // The appKey stored in Firebase
      String storedUserKey = userData['userKey']; // The userKey stored in Firebase
      String storedKey = storedAppKey+storedUserKey;
      // If no appKey exists in SharedPreferences, generate and save a new one
      if (appKey == null) {
        appKey = await _generateAndSaveAppKey(prefs);
      }

      // Generate a secure key by concatenating appKey and userKey
      String secureKey = generateSecureKey(appKey, userKey!);//uid from auth

      // Validate the generated secureKey with the stored appKey
      return validateUserAccess(secureKey, storedKey);
    } else {
      return false; // User data not found
    }
  }

  // Function to generate a new appKey and save it in SharedPreferences
  Future<String> _generateAndSaveAppKey(SharedPreferences prefs) async {
    // Generate a new appKey
    String newAppKey = _generateAppKey();

    // Save the new appKey in SharedPreferences
    await prefs.setString('appKey', newAppKey);

    return newAppKey;
  }

  // Generate a random app key (example: 16-character alphanumeric key)
  String _generateAppKey() {
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random _rnd = Random.secure();
    return String.fromCharCodes(Iterable.generate(16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  // Function to get appKey from SharedPreferences
  Future<String> getAppKey() async {
    final prefs = await SharedPreferences.getInstance();
    String? appKey = prefs.getString('appKey');

    if (appKey == null) {
      appKey = await _generateAndSaveAppKey(prefs);
    }

    return appKey;
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;  // Current user ID

    return FutureBuilder<String>(
      future: getAppKey(),  // Fetch the appKey from SharedPreferences
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        String appKey = snapshot.data!;  // Current app key

        // Now proceed with authorizing the user
        return FutureBuilder<bool>(
          future: authorizeUser(uid),  // Call authorizeUser() to validate the user
          builder: (context, AsyncSnapshot<bool> authSnapshot) {
            if (!authSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            bool isAuthorized = authSnapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: Text(userProfile.merchantName!),
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
                child: Text('Access Denied!'),  // Show this message if the user is not authorized
              ),
            );
          },
        );
      },
    );
  }
}
