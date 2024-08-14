import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInputCubitz extends Cubit<String> {
  PhoneInputCubitz() : super('');

  void updateDigit(int index, String digit) {
    String currentCode = state.padRight(6, ' ');
    List<String> codeList = currentCode.split('');
    codeList[index] = digit;
    emit(codeList.join());
  }
}
