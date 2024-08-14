import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_learning_app1/components/buttons.dart';
import 'package:online_learning_app1/blocs/num_bloc.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneInputCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1F1F39),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1F1F39),
        ),
        body: Center(
          child: Column(
            children: [
              const Text(
                'Continue with Phone',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30),
              SvgPicture.asset('assets/phoneicon.svg'),
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height * 0.63,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: BlocBuilder<PhoneInputCubit, String>(
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  TextFormField(
                                    controller: TextEditingController(text: state),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      filled: true,
                                      fillColor: Color(0xFF3E3E55),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: defaultButton(
                                        function: () {
                                          context
                                              .read<PhoneInputCubit>()
                                              .sendPhoneNumber(context);
                                        },
                                        text: 'Continue',
                                        height: 70,
                                        width: 124,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
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
                                    context
                                        .read<PhoneInputCubit>()
                                        .removeLastNumber();
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
                        )
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
        context.read<PhoneInputCubit>().addNumber(number);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        height: 48,
        alignment: Alignment.center,
        child: Text(
          '$number',
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
