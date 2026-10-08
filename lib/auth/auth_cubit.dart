import 'package:bloc_learning/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Cubit is similar to getxController
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthState(authState: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    if (email == "test@gmail.com" && password == "1234567") {
      emit(
        const AuthState(
          authState: AuthStatus.success,
          resMessage: "Login Succesfull",
        ),
      );
    } else {
      emit(
        const AuthState(
          authState: AuthStatus.error,
          resMessage: "Login Unsuccesfull",
        ),
      );
    }
  }
}
