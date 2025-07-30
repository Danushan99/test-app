import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order3000_flutter/constants/colors.dart';
import 'package:order3000_flutter/widgets/ios_style_button.dart';

import '../bloc/localization_bloc.dart';
import '../bloc/mail_bloc/email_bloc.dart';
import '../bloc/mail_bloc/email_event.dart';
import '../bloc/mail_bloc/email_state.dart';
import '../models/language.dart';
import '../repo/email_repo.dart';
import '../generate/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EmailBloc emailBloc;

  @override
  void initState() {
    super.initState();
    emailBloc = EmailBloc(
      repository: EmailRepository(baseUrl: 'http://localhost:3000'),
    );
    emailBloc.add(LoadEmails());
  }

  @override
  void dispose() {
    emailBloc.close();
    super.dispose();
  }

  void _openComposeSheet(BuildContext context) {
    final toController = TextEditingController();
    final subjectController = TextEditingController();
    final messageController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  'Compose New Email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: toController,
                  decoration: InputDecoration(
                    labelText: "Receiver's Email",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 24),
                Center(
                  child: IosStyleButton(
                    backgroundColor: AppColors.blackColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    borderRadius: BorderRadius.circular(12),
                    child: const Text(
                      "Send Email",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final to = toController.text.trim();
                      final subject = subjectController.text.trim();
                      final message = messageController.text.trim();

                      if (to.isEmpty || subject.isEmpty || message.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('All fields are required'),
                          ),
                        );
                        return;
                      }

                      emailBloc.add(SendEmail(
                        to: to,
                        subject: subject,
                        message: message,
                      ));

                      Navigator.of(context).pop();

                      Future.delayed(const Duration(milliseconds: 500), () {
                        emailBloc.add(LoadEmails());
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizationBloc = context.read<LocalizationBloc>();
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: emailBloc,
      child: Scaffold(
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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.helloWelcome,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<EmailBloc, EmailState>(
                    builder: (context, state) {
                      if (state is EmailLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is EmailLoaded) {
                        final emails = state.emails;
                        if (emails.isEmpty) {
                          return const Center(
                              child: Text(
                            'No emails found',
                            style: TextStyle(color: AppColors.redColor),
                          ));
                        }
                        return ListView.builder(
                          itemCount: emails.length,
                          itemBuilder: (context, index) {
                            final email = emails[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(email.subject),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('To: ${email.toEmail}'),
                                    Text(email.message),
                                    Text(
                                      email.sentAt.split('T').first,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is EmailError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: IosStyleButton(
            backgroundColor: AppColors.blackColor,
            child: Text(localizations.sentnewmaill),
            onPressed: () => _openComposeSheet(context),
          )),
    );
  }
}
