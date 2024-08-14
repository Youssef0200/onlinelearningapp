import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { initial, login, signup }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.initial);

  void navigateToLogin() => emit(NavigationState.login);

  void navigateToSignUp() => emit(NavigationState.signup);
}
