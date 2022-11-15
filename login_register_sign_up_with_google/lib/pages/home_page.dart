import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helpers/firebase_auth_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? data = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuthHelper.firebaseAuthHelper.SignOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('LoginPage', (route) => false);
            },
            icon: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 60),
            (data?.photoURL != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage("${data?.photoURL}"),
                    radius: 80,
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
            const SizedBox(height: 10),
            (data?.displayName != null)
                ? Text("Name:${data?.displayName}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold))
                : const Text("------"),
            const Divider(),
            (data?.email != null)
                ? Text("Email:${data?.email}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold))
                : const Text("------"),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (data?.photoURL != null)
                ? CircleAvatar(
                    backgroundImage: NetworkImage("${data?.photoURL}"),
                    radius: 80,
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.black,
                    ),
                  ),
            const SizedBox(height: 10),
            (data?.displayName != null)
                ? Text(
                    "Name:${data?.displayName}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : const Text("------"),
            const SizedBox(height: 10),
            (data?.email != null)
                ? Text(
                    "Email:${data?.email}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : const Text("------"),
          ],
        ),
      ),
    );
  }
}
