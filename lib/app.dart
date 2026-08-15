import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness App'),
        actions: [
          TextButton(
            onPressed: () => context.go(AppRoutes.home),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.workout),
            child: const Text('Workout'),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.profile),
            child: const Text('Profile'),
          ),
        ],
      ),

      body: child,
    );
  }
}
