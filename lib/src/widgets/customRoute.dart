import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    required WidgetBuilder builder, // Ensure builder is required
    required RouteSettings settings, // Ensure settings is required
  }) : super(builder: builder, settings: settings);



  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // If the route is 'MainPage', no transition is applied
    if (settings.name == "MainPage") {
      return child;
    }

    // Apply a fade transition with custom timing and curve
    return FadeTransition(
      opacity: animation.drive(Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
      child: child,
    );
  }
}
