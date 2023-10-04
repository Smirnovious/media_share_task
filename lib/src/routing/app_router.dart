import 'package:go_router/go_router.dart';
import '../common/home_screen.dart';
import '../media/view/edit_media_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        name: 'EditMediaScreen',
        path: '/editMedia',
        builder: (context, state) {
          final args = state.extra as List;
          return EditMediaScreen(args: args);
        }),
  ],
);
