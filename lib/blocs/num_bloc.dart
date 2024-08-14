import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_learning_app1/screens/phone_code.dart';

class PhoneInputCubit extends Cubit<String> {
  PhoneInputCubit() : super('');

  void addNumber(int number) {
    emit(state + number.toString());
  }

  void removeLastNumber() {
    if (state.isNotEmpty) {
      emit(state.substring(0, state.length - 1));
    }
  }

  void clear() {
    emit('');
  }

  Future<void> sendPhoneNumber(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String phoneNumberWithCountryCode = '+2' +
        state; // Replace '+2' with your desired country code

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumberWithCountryCode,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        // Navigate to the home screen or another screen if automatically verified
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The provided phone number is not valid.')),
          );
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navigate to the code verification screen, passing the verificationId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerificationCodeScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout if needed
      },
    );
  }
}
