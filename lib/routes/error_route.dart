import 'package:flutter/material.dart';

class ErrorRouteScreen extends StatelessWidget {
  const ErrorRouteScreen({super.key, this.message = 'No page found'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 30,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
