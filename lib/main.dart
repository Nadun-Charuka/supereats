import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supereats/pages/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://tnotihdjodszypvogvrh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRub3RpaGRqb2Rzenlwdm9ndnJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4OTcxMjcsImV4cCI6MjA2MTQ3MzEyN30.ilWADm0Kr1XsZswImyZauXA7nEzD8kFqgW1dCe7tMKw',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Supereats",
      home: LoginScreen(),
    );
  }
}
