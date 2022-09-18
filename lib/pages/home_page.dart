import 'package:firepost/pages/signup_page.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignUpPage.id);
                },
                icon: Icon(Icons.add)),
          ],
          title: Text('Home'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                AuthService.signOutUser(context);
              },
              child: Text('Log out'),
            ),
          ),
        ));
  }
}
