import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/pages/auth/login_screen.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  //signup function
  Future<String?> signup(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        password: password,
        email: email,
      );

      if (response.user != null) {
        return null;
      }
      return "SignUp error";
    } on AuthApiException catch (e) {
      return e.message;
    } catch (e) {
      return "Error: $e";
    }
  }

  //login function
  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user != null) {
        return null;
      }
      return "Invalid email or password";
    } on AuthApiException catch (e) {
      return e.message;
    } catch (e) {
      return "Error: $e";
    }
  }

  //logout function
  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
