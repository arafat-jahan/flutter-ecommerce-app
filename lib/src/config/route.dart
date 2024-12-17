import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_apps/src/pages/mainPage.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(), // Ensure MainPage is correctly defined
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
