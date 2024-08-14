import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_learning_app1/firebase_auth//auth_service.dart';
import 'package:online_learning_app1/blocs/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUpWithEmailAndPassword(email, password);
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithEmailAndPassword(email, password);
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
  void toggleCheckbox(bool isChecked) {
    emit(AuthCheckboxState(isChecked));
  }
  void togglePasswordVisibility(bool isVisible) {
    emit(AuthPasswordVisibilityState(isVisible));
  }
}
