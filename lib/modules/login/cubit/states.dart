 abstract class LoginStates{}

 class InitialState extends LoginStates{}

 class LoadingLoginState extends LoginStates{}

 class LoginSuccessState extends LoginStates{
 final String uId;

 LoginSuccessState(this.uId);

 }

 class LoginErrorState extends LoginStates{}


 class NavigateSuccessState extends LoginStates{}

 class NavigateErrorState extends LoginStates{}

 class PasswordVisibilityChangeState extends LoginStates{}