import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:one_aviation/src/screens/home/home_screen.dart';
import 'package:one_aviation/src/screens/navigation/bottom_navigation.dart';

class Routes {
  static const String main = "/";
  static const String login = "auth/login";
  static const String registration = "auth/registration";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  Route generateRoute(RouteSettings routeSettings) {
    return Routes.fadeThrough(routeSettings, (context) {
      switch (routeSettings.name) {
        case Routes.main:
          return BottomNavigation();
        case Routes.login:
          return HomeScreen();
        case Routes.registration:
          return HomeScreen();
        default:
          return SizedBox.shrink();
      }
    });
  }
}
