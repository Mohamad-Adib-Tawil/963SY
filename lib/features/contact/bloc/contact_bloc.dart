import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/core/network/api_client.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<SubmitContactForm>(_onSubmitContactForm);
    on<LoadContactInfo>(_onLoadContactInfo);
  }

  void _onSubmitContactForm(
      SubmitContactForm event, Emitter<ContactState> emit) async {
    try {
      emit(ContactLoading());

      final response = await ApiClient.instance.post(
        'https://963sy.net/api/user/contact-admin',
        data: {
          'name': event.name,
          'email': event.email,
          'subject': event.subject,
          'message': event.message,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(const ContactFormSubmitted(
          success: true,
          message: 'تم إرسال رسالتك بنجاح!',
        ));
      } else {
        emit(const ContactFormSubmitted(
          success: false,
          message: 'فشل في إرسال الرسالة.',
        ));
      }
    } catch (e) {
      emit(ContactError('خطأ أثناء الإرسال: ${e.toString()}'));
    }
  }

  void _onLoadContactInfo(
      LoadContactInfo event, Emitter<ContactState> emit) async {
    try {
      emit(ContactLoading());

      final contactInfo = {
        'email': 'info@syriatourism.com',
        'phone': '+963 11 1234567',
        'address': 'Damascus, Syria',
        'socialMedia': {
          'facebook': 'https://facebook.com/syriatourism',
          'twitter': 'https://twitter.com/syriatourism',
          'instagram': 'https://instagram.com/syriatourism',
        },
      };

      emit(ContactInfoLoaded(contactInfo: contactInfo));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
