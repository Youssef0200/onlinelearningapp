import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning_app1/blocs/auth_cubit.dart';
import 'package:online_learning_app1/blocs/auth_state.dart';
import 'package:online_learning_app1/components/buttons.dart';
import 'package:online_learning_app1/firebase_auth//auth_service.dart';
import 'package:online_learning_app1/screens/phone_screen.dart';
import 'package:online_learning_app1/screens/signup.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(FirebaseAuthService()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PhoneScreen()),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Incorrect email or password')),
            );
          }
        },
        builder: (context, state) {
          bool isPasswordVisible = false;
          if (state is AuthPasswordVisibilityState) {
            isPasswordVisible = state.isPasswordVisible;
          }

          return Scaffold(
            backgroundColor: Color(0xFF1F1F39),
            appBar: AppBar(
              backgroundColor: Color(0xFF1F1F39),
              elevation: 0,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2F2F42),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 50,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Your Email',
                                      style: TextStyle(
                                        color: Color(0xFF858597),
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter email';
                                        }
                                        final emailRegex = RegExp(
                                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                        );
                                        if (!emailRegex.hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
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
                                    const SizedBox(height: 20),
                                    const Text(
                                      'Password',
                                      style: TextStyle(
                                        color: Color(0xFF858597),
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(color: Colors.white),
                                      controller: passwordController,
                                      obscureText: !isPasswordVisible,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(15),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                            color: Color(0xFFB8B8D2),
                                          ),
                                          onPressed: () {
                                            context.read<AuthCubit>().togglePasswordVisibility(!isPasswordVisible);
                                          },
                                        ),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(onPressed: () {

                                        }, child: const Text('Forgot password?',
                                            style: TextStyle(
                                              color: Color(0xFFB8B8D2)
                                            ))

                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    defaultButton(
                                      width: double.infinity,
                                      function: () async {
                                        if (formKey.currentState!.validate()) {
                                          context.read<AuthCubit>().signIn(
                                            emailController.text,
                                            passwordController.text,
                                          );
                                        }
                                      },
                                      text: 'Log In',
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Don’t have an account?',
                                          style: TextStyle(color: Color(0xFFB8B8D2)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const SignUpScreen(),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Sign up',
                                            style: TextStyle(color: Color(0xFF3D5CFF)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}