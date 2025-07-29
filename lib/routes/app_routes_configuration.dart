import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order3000_flutter/routes/app_routes_constants.dart';
//Screens

import 'package:order3000_flutter/routes/error_route.dart';
import 'package:order3000_flutter/screens/home_screen.dart';

class AppRoutes {

  static GoRouter router = GoRouter(
      routes: [
  
        GoRoute(
            path: '/',
            name: AppRoutesConstants.homeScreenRouteName,
            builder: (context, state) => const HomePage()),
        
      ],
      errorPageBuilder: (context, state) =>
          (const MaterialPage(child: ErrorRouteScreen())));
}
