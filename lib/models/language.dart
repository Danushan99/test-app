import 'dart:ui';

// import '../../gen/assets.gen.dart';

enum Language {
  english(Locale('en', 'US'), 'English'),
  german(Locale('de', 'DE'), 'German'),
  tamil(Locale('ta', 'IN'), 'தமிழ்');

  const Language(this.value, this.text);

  final Locale value;

  final String text;
}
