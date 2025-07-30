import 'package:equatable/equatable.dart';

abstract class EmailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEmails extends EmailEvent {}

class SendEmail extends EmailEvent {
  final String to;
  final String subject;
  final String message;

  SendEmail({required this.to, required this.subject, required this.message});

  @override
  List<Object?> get props => [to, subject, message];
}
