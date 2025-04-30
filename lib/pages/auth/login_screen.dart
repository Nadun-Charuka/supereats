import 'package:flutter/material.dart';
import 'package:supereats/pages/auth/signup_screen.dart';
import 'package:supereats/screens/onboarding_screen.dart';
import 'package:supereats/services/auth_service.dart';
import 'package:supereats/widgets/auth_button.dart';
import 'package:supereats/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _authService = AuthService();
  bool isLoading = false;
  bool isPassowrdHidden = true;

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    final result = await _authService.login(email, password);

    if (result == null) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Login Successful");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    } else {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Login failed $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/login.jpg",
                width: double.maxFinite,
                height: 500,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: isPassowrdHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassowrdHidden = !isPassowrdHidden;
                      });
                    },
                    icon: Icon(
                      isPassowrdHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : AuthButton(
                      buttonText: "Login",
                      onTap: () {
                        _login();
                      },
                    ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Dont have an account?   ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "SignUp here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                        fontSize: 18,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
