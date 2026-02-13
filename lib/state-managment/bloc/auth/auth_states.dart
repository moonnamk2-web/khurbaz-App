abstract class AuthStates {
  const AuthStates();
}

class LoginStateInitial extends AuthStates {}

class LoginStarted extends AuthStates {}


class OTPSent extends AuthStates {
  String phoneNumber;

  OTPSent({required this.phoneNumber});
}

class RegisterState extends AuthStates {}

class LoginFinishedSuccessfully extends AuthStates {}

class LoginFinishedWithError extends AuthStates {}

class LogoutState extends AuthStates {}
