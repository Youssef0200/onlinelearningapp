import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeCubit extends Cubit<String> {
  VerificationCodeCubit() : super('');

  void addNumber(int number) {
    if (state.length < 6) {
      emit(state + number.toString());
    }
  }

  void removeLastNumber() {
    if (state.isNotEmpty) {
      emit(state.substring(0, state.length - 1));
    }
  }

  void clearCode() {
    emit('');
  }
}
