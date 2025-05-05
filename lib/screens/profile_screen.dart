import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:supereats/providers/favorite_provider.dart';
import 'package:supereats/services/auth_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              if (userId != null) {
                await supabase.from('favorites').delete().eq('user_id', userId);
              }
              ref.read(favoriteProvider.notifier).reset();
              if (!context.mounted) return;
              await authService.logout(context);
            },
            icon: Icon(
              Icons.login,
            ),
          )
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
