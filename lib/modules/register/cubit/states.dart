abstract class RegisterStates{}

class InitialRegisterState extends RegisterStates{}

class LoadingRegisterState extends RegisterStates{}

 class SuccessRegisterState extends RegisterStates{}

 class ErrorRegisterState extends RegisterStates{

  final String error;

  ErrorRegisterState(this.error);
 }

class LoadingUserCreateState extends RegisterStates{}

class SuccessUserCreateState extends RegisterStates{}

class ErrorUserCreateState extends RegisterStates{

 final String error;

 ErrorUserCreateState(this.error);
}
class EyeChangeState extends RegisterStates{}