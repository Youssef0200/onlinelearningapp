import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning_app1/blocs/Verification_Code_Cubit.dart';

class Otp extends StatelessWidget {
  final int index;

  const Otp({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCodeCubit, String>(
      builder: (context, otp) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFF3E3E55),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            index < otp.length ? otp[index] : '',
            style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
