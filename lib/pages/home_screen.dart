import 'package:flutter/material.dart';
import 'package:supereats/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                authService.logout(context);
              },
              icon: Icon(
                Icons.login,
              ))
        ],
      ),
    );
  }
}
