import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_learning_app1/Onboarding/onboarding_items.dart';
import 'package:online_learning_app1/blocs/navigation.dart';
import 'package:online_learning_app1/components/buttons.dart';
import 'package:online_learning_app1/screens/login.dart';
import 'package:online_learning_app1/screens/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();
  final NavigationCubit _navigationCubit = NavigationCubit(); // Direct instantiation of NavigationCubit
  int currentPage = 0;

  @override
  void dispose() {
    _navigationCubit.close(); // Close the cubit when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      body: BlocListener<NavigationCubit, NavigationState>(
        bloc: _navigationCubit, // Use the locally created cubit
        listener: (context, state) {
          if (state == NavigationState.login) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          } else if (state == NavigationState.signup) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6.h,
              child: PageView.builder(
                controller: pageController,
                itemCount: controller.items.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index; // Update the current page index
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Use a SizedBox to maintain space for the skip button
                      SizedBox(
                        height: 50, // Adjust height as needed
                        child: index < 2
                            ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 16.0),
                            child: TextButton(
                              onPressed: () {
                                // Navigate to the next page or skip to the last page
                                pageController.jumpToPage(
                                    controller.items.length - 1);
                              },
                              child:  Text(
                                "Skip",
                                style: TextStyle(
                                  color: Color(0xFFB8B8D2),
                                  fontSize: 14.0.sp,
                                ),
                              ),
                            ),
                          ),
                        )
                            : const SizedBox(), // Empty space placeholder
                      ),
                      SvgPicture.asset(controller.items[index].image),
                       SizedBox(height: 15.sp),
                      Text(
                        controller.items[index].title,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0.sp,
                        ),
                      ),
                       SizedBox(height: 15.h),
                      Text(
                        controller.items[index].descriptions,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: 16.0.sp,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
             SizedBox(height: 10.sp),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              effect:  ExpandingDotsEffect(
                activeDotColor: Color(0xFF3D5CFF),
                dotHeight: 5.h,
                dotWidth: 9.w
                ,
              ),
            ),
             SizedBox(height: 20.h),
            Container(
              height: MediaQuery.of(context).size.height * 0.1.h,
            ),
            Container(
              height: 50, // Fixed height to maintain layout consistency
              alignment: Alignment.center,
              child: currentPage == controller.items.length - 1
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultButton(
                    function: () {
                      _navigationCubit.navigateToSignUp(); // Trigger navigation to Sign Up
                    },
                    text: 'Sign up',
                  ),
                   SizedBox(width: 15.w),
                  defaultButton(
                    function: () {
                      _navigationCubit.navigateToLogin(); // Trigger navigation to Log In
                    },
                    text: 'Log in',
                    background: Color(0xFF858597),
                    borderColor: Color(0xFF3D5CFF),
                  ),
                ],
              )
                  : const SizedBox.shrink(), // Placeholder for non-visible buttons
            ),
          ],
        ),
      ),
    );
  }
}
