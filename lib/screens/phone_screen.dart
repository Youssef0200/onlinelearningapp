import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_learning_app1/components/buttons.dart';
import 'package:online_learning_app1/blocs/num_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
               Text(
                'Continue with Phone',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
               SizedBox(height: 30.h),
              // SvgPicture.asset('assets/phoneicon.svg',width: 128.w,height: 128.h,),
              //  SizedBox(height: 30.h),
              Container(
                height: MediaQuery.of(context).size.height * 0.63.h,
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
                                  Container(
                                    width:340.w,
                                    height: 50.h,
                                    child: TextFormField(

                                      controller: TextEditingController(text: state),
                                      style:  TextStyle(
                                          color: Colors.white, fontSize: 24.sp),
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
                                        height: 50.h,
                                        width: 124.w,
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
                          if (i < 2)  SizedBox(height: 36.h),
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
                                  child:  Icon(
                                    Icons.backspace_outlined,
                                    color: Colors.white,
                                    size: 24.sp,
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
        width: 80.w,
        height: 48.h,
        alignment: Alignment.center,
        child: Text(
          '$number',
          style:  TextStyle(
              fontSize: 24.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
