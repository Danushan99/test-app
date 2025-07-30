import 'package:equatable/equatable.dart';

import '../../models/email.dart';

abstract class EmailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailLoaded extends EmailState {
  final List<Email> emails;

  EmailLoaded(this.emails);

  @override
  List<Object?> get props => [emails];
}

class EmailSendSuccess extends EmailState {}

class EmailError extends EmailState {
  final String message;

  EmailError(this.message);

  @override
  List<Object?> get props => [message];
}
