// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order3000_flutter/bloc/localization_bloc.dart';
import 'package:order3000_flutter/generate/app_localizations.dart';
import 'package:order3000_flutter/routes/app_routes_configuration.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = AppRoutes.router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocalizationBloc()..add(GetLanguage()),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, AppLocalizationState>(
        buildWhen: (previous, current) =>
            previous.selectedLanguage != current.selectedLanguage,
        builder: (context, state) {
          return MaterialApp.router(
            locale: state.selectedLanguage.value,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            routerDelegate: _router.routerDelegate,
            routeInformationParser: _router.routeInformationParser,
            routeInformationProvider: _router.routeInformationProvider,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
