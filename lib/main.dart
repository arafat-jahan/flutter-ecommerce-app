import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_apps/src/config/route.dart';
import 'package:flutter_ecommerce_apps/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_apps/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_apps/src/widgets/customRoute.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(), // Set up named routes correctly
      onGenerateRoute: (RouteSettings settings) {
        // Handle custom routes here
        switch (settings.name) {
          case '/productDetail':
            return CustomRoute<bool>(
              settings: settings, // Pass settings here
              builder: (BuildContext context) => ProductDetailPage(),
            );
          default:
            return CustomRoute<bool>(
              settings: settings, // Pass settings here
              builder: (BuildContext context) => MainPage(),
            );
        }
      },
      initialRoute: '/', // Make sure the initial route is '/'
    );
  }
}
