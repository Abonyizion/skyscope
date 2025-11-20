import 'package:go_router/go_router.dart';
import '../../presentation/screens/home_page.dart';
import '../../presentation/screens/splash_screen.dart';

class AppRouter {
  /// ********* ROUTE PATHS *********
  static const String splash = '/splash';
  static const String home = '/home';

  /// ********* GOROUTER SETUP *********
  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (_, __) => SplashPage(),
      ),
      GoRoute(
        path: home,
        builder: (_, __) => const WeatherHomePage(),
      ),
    ],
  );
}
