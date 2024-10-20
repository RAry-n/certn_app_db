// home.dart or equivalent page
import 'package:certin/user_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'encryption_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Method to handle logout
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navigate the user to the login screen or show a message
    Navigator.of(context).pushReplacementNamed('/get_started'); // Adjust the route as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<UserProfile>>(
        future: fetchAllUsers(),
        builder: (context, AsyncSnapshot<List<UserProfile>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(users[index].imgUrl!),
                ),
                title: Text(users[index].merchantName!),
                subtitle: Text(users[index].shopName!),
                onTap: () {
                  // Navigate to User Details page with secure authorization
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(
                        userProfile: users[index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<UserProfile>> fetchAllUsers() async {
    final ref = FirebaseDatabase.instance.ref('profile'); // Path to the users data in Firebase
    final snapshot = await ref.get();

    if (snapshot.exists) {
      print("snap exist");
      try {
        var response = Map<String, Object?>.from(snapshot.value as Map);
        Map<String, dynamic> usersMap = {};
        List<UserProfile> list = [];

        // Create an instance of the EncryptionHelper
        final encryptionHelper = EncryptionHelper();

        for (var item in response.entries) {
          usersMap[item.key] = item.value;

          // Decrypt each piece of sensitive data
          String appKey = encryptionHelper.decryptData(usersMap[item.key]['appKey']);
          String imgUrl = usersMap[item.key]['imgUrl'];
          String merchantID = encryptionHelper.decryptData(usersMap[item.key]['merchantID']);
          String merchantName = encryptionHelper.decryptData(usersMap[item.key]['merchantName']);
          String shopAddress = encryptionHelper.decryptData(usersMap[item.key]['shopAddress']);
          String shopName = encryptionHelper.decryptData(usersMap[item.key]['shopName']);
          String userKey = encryptionHelper.decryptData(usersMap[item.key]['userKey']);

          list.add(UserProfile(
            appKey: appKey,
            imgUrl: imgUrl,
            merchantID: merchantID,
            merchantName: merchantName,
            shopAddress: shopAddress,
            shopName: shopName,
            userKey: userKey,
          ));
        }

        print("list is $list");
        return list;
      } catch (e) {
        print(e);
      }
    } else {
      return [];
    }
    return [];
  }

// Fetch all registered users from Firebase Realtime Database
//   Future<List<UserProfile>> fetchAllUsers() async {
//     final ref = FirebaseDatabase.instance.ref('profile'); // Path to the users data in Firebase
//     final snapshot = await ref.get();
//
//     if (snapshot.exists) {
//       print("snap exist");
//       try {
//         var response = Map<String, Object?>.from(snapshot.value as Map);
//         Map<String,dynamic> usersMap = {};
//         List<UserProfile> list = [];
//         final encryptionHelper = EncryptionHelper();
//         for(var item in response.entries)
//           {
//             usersMap[item.key]=item.value;
//             print(usersMap[item.key]);
//             list.add(UserProfile(appKey: usersMap[item.key]['appKey'],
//               imgUrl: usersMap[item.key]['imgUrl'],
//               merchantID: usersMap[item.key]['merchantID'],
//               merchantName: usersMap[item.key]['merchantName'],
//               shopAddress: usersMap[item.key]['shopAddress'],
//               shopName: usersMap[item.key]['shopName'],
//               userKey: usersMap[item.key]['userKey'],));
//           }
//         /*final users = usersMap.entries
//             .map((entry) => UserProfile.fromMap(entry.value))
//             .toList();*/
//         print("list is $list");
//
//
//         return list;
//       }
//       catch(e)
//     {
//       print(e);
//     }
//
//     } else {
//       return [];
//     }
//     return [];
//   }
}

// UserProfile class to model the user's data
class UserProfile {
  final String? appKey;
  final String? imgUrl;
  final String? merchantID;
  final String? merchantName;
  final String? shopAddress;
  final String? shopName;
  final String? userKey;

  UserProfile({
    required this.appKey,
    required this.imgUrl,
    required this.merchantID,
    required this.merchantName,
    required this.shopAddress,
    required this.shopName,
    required this.userKey,
  });

  // Factory method to create a UserProfile from a map
  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      appKey: data['appKey'],
      imgUrl: data['imgUrl'],
      merchantID: data['merchantID'],
      merchantName: data['merchantName'],
      shopAddress: data['shopAddress'],
      shopName: data['shopName'],
      userKey: data['userKey'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "ListElement($appKey, $merchantName $merchantID $shopName $shopAddress $userKey $imgUrl)";
  }
}
