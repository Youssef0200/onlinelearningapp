import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_learning_app1/components/OTP.dart';
import 'package:online_learning_app1/components/buttons.dart';
import 'package:online_learning_app1/blocs/Verification_Code_Cubit.dart';
import 'package:online_learning_app1/screens/home_screen.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String verificationId;

  const VerificationCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerificationCodeCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF2F2F42),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2F2F42),
        ),
        body: Center(
          child: Column(
            children: [
              const Text(
                'Verify Phone',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height * 0.8229,

                decoration: const BoxDecoration(
                  color: Color(0xFF2F2F42),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Builder(
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Code is sent to 283 835 2999 ',
                          style: TextStyle(color: Color(0xFFB8B8D2), fontSize: 18),
                        ),
                        Container(height: MediaQuery.of(context).size.height * 0.03 ,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) => Otp(index: index)), // Use Otp widget here
                          ),
                        ),
                        const SizedBox(height: 30),
                        defaultButton(
                          width: MediaQuery.of(context).size.width * 0.8,
                          function: () async {
                            final otp = context.read<VerificationCodeCubit>().state;
                            final credential = PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otp,
                            );

                            try {
                              await FirebaseAuth.instance.signInWithCredential(credential);
                              // Navigate to the home screen or another screen
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => HomeScreen()), // Replace HomeScreen with your desired widget
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Invalid code, please try again')),
                              );
                            }
                          },
                          text: 'Verify and Log in',
                        ),
                        const SizedBox(height: 30),
                        for (var i = 0; i < 3; i++) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                3,
                                    (index) => numButton(context, 1 + 3 * i + index),
                              ).toList(),
                            ),
                          ),
                          if (i < 2) const SizedBox(height: 36),
                        ],
                        Padding(
                          padding: const EdgeInsets.all(36),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 120),
                                child: numButton(context, 0),
                              ),
                              Container(
                                width: 80,
                                height: 48,
                                child: TextButton(
                                  onPressed: () {
                                    context.read<VerificationCodeCubit>().removeLastNumber();
                                  },
                                  child: const Icon(
                                    Icons.backspace_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget numButton(BuildContext context, int number) {
    return InkWell(
      onTap: () {
        context.read<VerificationCodeCubit>().addNumber(number);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        height: 48,
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}