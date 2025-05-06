import 'package:flutter/material.dart';
import 'package:supereats/pages/auth/login_screen.dart';
import 'package:supereats/services/auth_service.dart';
import 'package:supereats/widgets/auth_button.dart';
import 'package:supereats/widgets/snackbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (!email.contains(".com")) {
      showSnackBar(context, "Invalid email");
    }
    setState(() {
      isLoading = true;
    });
    final result = await _authService.signup(email, password);
    if (result == null) {
      if (!mounted) return;
      showSnackBar(context, "SignUp sucessfull");
      setState(() {
        isLoading = false;
      });
    } else {
      if (!mounted) return;
      showSnackBar(context, "SignUp failed: $result");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/auth/signup.jpg",
                width: double.maxFinite,
                height: 500,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
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
                      buttonText: 'SignUp',
                      onTap: () {
                        _signUp();
                      },
                      color: Colors.red.withValues(alpha: 0.5),
                    ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Already have an account?   ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Login here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                        fontSize: 18,
                        color: Colors.redAccent,
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
