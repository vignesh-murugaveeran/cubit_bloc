import 'package:bloc_learning/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Cubit is similar to getxController
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthState(authState: AuthStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.isNotEmpty) {
      if (email == "abc@gmail.com" && password == "123456") {
        emit(
          state.copyWith(
            authState: AuthStatus.success,
            resMessage: "Login Succesfull",
          ),
        );
        return;
      } else {
        emit(
          state.copyWith(
            authState: AuthStatus.error,
            resMessage: "Invalid Login ID or Password.",
          ),
        );
        return;
      }
    } else {
      if (email.isEmpty || password.isEmpty) {
        emit(
          state.copyWith(
            authState: AuthStatus.error,
            resMessage: "Please fill the fields",
          ),
        );
        return;
      } else {
        emit(
          state.copyWith(
            authState: AuthStatus.error,
            resMessage: "Login Unsuccesfull",
          ),
        );
        return;
      }
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(authState: AuthStatus.loading));

    await Future.delayed(const Duration(seconds: 1));

    emit(
      state.copyWith(
        authState: AuthStatus.initial,
        resMessage: "Logout Successful",
      ),
    );
  }
}
