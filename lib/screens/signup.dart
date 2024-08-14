import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning_app1/blocs/auth_cubit.dart';
import 'package:online_learning_app1/components/buttons.dart';
import 'package:online_learning_app1/firebase_auth//auth_service.dart';
import 'package:online_learning_app1/blocs/auth_state.dart';
import 'package:online_learning_app1/screens/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F39),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1F39),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => AuthCubit(FirebaseAuthService()),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Navigate to HomeScreen or another screen after successful registration
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Login()), // Replace with your desired screen
              );
            } else if (state is AuthFailure) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            bool isChecked = false;
            if (state is AuthCheckboxState) {
              isChecked = state.isChecked;
            }
            bool isPasswordVisible = false;
            if (state is AuthPasswordVisibilityState) {
              isPasswordVisible = state.isPasswordVisible;
            }
            return LayoutBuilder(
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
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                'Enter your details below & free sign up',
                                style: TextStyle(
                                  color: Color(0xFFB8B8D2),
                                  fontSize: 12.0,
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
                                              isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Color(0xFFB8B8D2)),
                                          onPressed: () {
                                            context
                                                .read<AuthCubit>()
                                                .togglePasswordVisibility(
                                                !isPasswordVisible);
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
                                    const SizedBox(height: 20),
                                    state is AuthLoading
                                        ? Center(
                                        child: CircularProgressIndicator())
                                        : defaultButton(
                                      width: double.infinity,
                                      text: 'Create account',
                                      function: () {
                                        if (formKey.currentState!
                                            .validate()) {
                                          context
                                              .read<AuthCubit>()
                                              .signUp(
                                            emailController.text,
                                            passwordController.text,
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            context
                                                .read<AuthCubit>()
                                                .toggleCheckbox(value ?? false);
                                          },
                                          activeColor: Color(0xFF4A58FF),
                                          checkColor: Colors.white,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'By creating an account you have to agree \nwith our term & condition.',
                                            style: TextStyle(
                                              color: Color(0xFFB8B8D2),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Already have an account ?',
                                          style: TextStyle(
                                              color: Color(0xFFB8B8D2)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                const Login(), // Navigate directly to the Register widget
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Log in',
                                            style: TextStyle(
                                                color: Color(0xFF3D5CFF)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
