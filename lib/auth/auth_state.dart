enum AuthStatus { initial, loading, success, error }

///which is similar like model class in getx
class AuthState {
  final AuthStatus authState;
  final String? resMessage;

  const AuthState({this.authState = AuthStatus.initial, this.resMessage});

  AuthState copyWith({AuthStatus? authState, String? resMessage}) {
    return AuthState(
      authState: authState ?? this.authState,
      resMessage: resMessage ?? this.resMessage,
    );
  }
}
