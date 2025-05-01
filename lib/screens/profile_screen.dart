import 'package:flutter/material.dart';
import 'package:supereats/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        actions: [
          IconButton(
            onPressed: () {
              authService.logout(context);
            },
            icon: Icon(
              Icons.login,
            ),
          )
        ],
      ),
    );
  }
}
