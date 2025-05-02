import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/pages/auth/login_screen.dart';
import 'package:supereats/screens/app_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://tnotihdjodszypvogvrh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRub3RpaGRqb2Rzenlwdm9ndnJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4OTcxMjcsImV4cCI6MjA2MTQ3MzEyN30.ilWADm0Kr1XsZswImyZauXA7nEzD8kFqgW1dCe7tMKw',
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
          cardTheme: CardTheme(
            color: Colors.white,
          )),
      debugShowCheckedModeBanner: false,
      title: "Supereats",
      home: AuthCheck(),
    );
  }
}

//to saty the homescreen until logout
class AuthCheck extends StatelessWidget {
  final supabase = Supabase.instance.client;
  AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (contex, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          return AppMainScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
