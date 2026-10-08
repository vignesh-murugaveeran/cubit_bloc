enum AuthStatus { inital, loading, success, error }

class AuthState {
  final AuthStatus authState;
  final String? resMessage;

  const AuthState({this.authState = AuthStatus.inital, this.resMessage});
}
