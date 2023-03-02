import 'package:flutter/material.dart';
import 'package:flutter_bloc_practise/presentation/screens/detail_screen/detail_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';
import '../common_widgets/common_widgets.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String details = '/details';
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: Strings.homeScreenTitle,
          ),
        );

      case details:
        return MaterialPageRoute(
          builder: (_) => const DetailsScreen(),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
