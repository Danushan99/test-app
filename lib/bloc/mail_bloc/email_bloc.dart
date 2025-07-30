import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/email_repo.dart';
import 'email_event.dart';
import 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final EmailRepository repository;

  EmailBloc({required this.repository}) : super(EmailInitial()) {
    on<LoadEmails>((event, emit) async {
      emit(EmailLoading());
      try {
        final emails = await repository.fetchEmails();
        emit(EmailLoaded(emails));
      } catch (e) {
        emit(EmailError(e.toString()));
      }
    });

    on<SendEmail>((event, emit) async {
      emit(EmailLoading());
      try {
        await repository.sendEmail(event.to, event.subject, event.message);
        final emails = await repository.fetchEmails();
        emit(EmailLoaded(emails));
      } catch (e) {
        emit(EmailError(e.toString()));
      }
    });
  }
}
