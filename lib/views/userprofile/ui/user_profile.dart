import 'package:flutter/material.dart';

import 'user_profile_screen.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Container(
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
        children: <Widget>[UserProfilePage()],
      )))),
    );
  }
}
