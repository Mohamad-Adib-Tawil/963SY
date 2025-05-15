part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactInfoLoaded extends ContactState {
  final Map<String, dynamic> contactInfo;

  const ContactInfoLoaded({required this.contactInfo});

  @override
  List<Object> get props => [contactInfo];
}

class ContactFormSubmitted extends ContactState {
  final bool success;
  final String? message;

  const ContactFormSubmitted({
    required this.success,
    this.message,
  });

  @override
  List<Object> get props => [success, message ?? ''];
}

class ContactError extends ContactState {
  final String message;

  const ContactError(this.message);

  @override
  List<Object> get props => [message];
}
