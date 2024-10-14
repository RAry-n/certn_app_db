// In your home.dart or equivalent page
import 'package:certin/user_detail_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: FutureBuilder(
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
                title: Text(users[index].name),
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
    final ref = FirebaseDatabase.instance.ref('profile');
    final snapshot = await ref.get();
    final usersMap = Map<String, dynamic>.from(snapshot.value as Map);
    final users = usersMap.entries
        .map((entry) => UserProfile.fromMap(entry.value))
        .toList();
    return users;
  }
}

class UserProfile {
  final String name;
  final String shopName;
  final String merchantID;
  final String shopAddress;

  UserProfile({
    required this.name,
    required this.shopName,
    required this.merchantID,
    required this.shopAddress,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      name: data['merchantName'],
      shopName: data['shopName'],
      merchantID: data['merchantID'],
      shopAddress: data['shopAddress'],
    );
  }
}
