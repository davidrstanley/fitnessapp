import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';
import 'pages/workout_page.dart';
import 'pages/profile_page.dart';

/// Central location for route paths
class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const workout = '/workout';
  static const profile = '/profile';
}

/// Central router configuration
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.workout,
      builder: (context, state) => const WorkoutPage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);
