part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final RequestState? checkUserNameState;
  final RequestState? loginState;
  final RequestState? registerState;
  final UserResponse? userResponse;
  final RequestState? getResponseForLoginState;
  final RequestState? changeDataLoginState;

  const AuthState({this.checkUserNameState,
    this.loginState,
    this.registerState,this.getResponseForLoginState,this.changeDataLoginState,
    this.userResponse});

  AuthState copyWith({ final RequestState? checkUserNameState,
    final RequestState? loginState,
    final RequestState? registerState,
    final RequestState? getResponseForLoginState,
    final RequestState? changeDataLoginState,
    final UserResponse? userResponse}) =>
      AuthState(
        getResponseForLoginState: getResponseForLoginState ?? this.getResponseForLoginState,
        changeDataLoginState: changeDataLoginState ?? this.changeDataLoginState,
        checkUserNameState: checkUserNameState ?? this.checkUserNameState,
        loginState: loginState ?? this.loginState,
        registerState: registerState ?? this.registerState,
        userResponse: userResponse ?? this.userResponse,
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [loginState, checkUserNameState, registerState, userResponse,getResponseForLoginState,changeDataLoginState];
}
