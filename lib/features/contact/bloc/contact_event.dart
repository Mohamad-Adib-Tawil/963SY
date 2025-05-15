part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class SubmitContactForm extends ContactEvent {
  final String name;
  final String email;
  final String subject;
  final String message;

  const SubmitContactForm({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
  });

  @override
  List<Object> get props => [name, email, subject, message];
}

class LoadContactInfo extends ContactEvent {
  const LoadContactInfo();

  @override
  List<Object> get props => [];
}
