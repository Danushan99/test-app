import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order3000_flutter/bloc/localization_bloc.dart';
import 'package:order3000_flutter/constants/colors.dart';

import 'package:order3000_flutter/generate/app_localizations.dart';
import 'package:order3000_flutter/models/language.dart';
import 'package:order3000_flutter/widgets/ios_style_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationBloc = context.read<LocalizationBloc>();
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.home),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PopupMenuButton<Language>(
              icon: const Icon(Icons.translate),
              onSelected: (Language lang) {
                localizationBloc
                    .add(ChangeLanguage(lang, selectedLanguage: lang));
              },
              itemBuilder: (context) {
                return Language.values.map((lang) {
                  return PopupMenuItem(
                    value: lang,
                    child: Text(lang.text),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              localizations.helloWelcome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grayColor),
            ),
            IosStyleButton(
                backgroundColor: AppColors.blackColor,
                child: Text(localizations.logoin),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
