import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Display Large', style: textTheme.displayLarge),
            Text('Headline Medium', style: textTheme.headlineMedium),
            Text('Title Small', style: textTheme.titleSmall),
            Text('Body Large', style: textTheme.bodyLarge),
            Text('Label Small', style: textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
