
 import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialState());

  static LoginCubit get(context)=> BlocProvider.of(context);

 void userLogin({
  required String email,
   required String password,

}) async {
   emit(LoadingLoginState());


  await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   ).then((value){
     print(value.user!.email);
     print(value.user!.uid);

     emit(LoginSuccessState(value.user!.uid));

   }).catchError((error){
    emit(LoginErrorState());
  });

 }
 bool password = true;
 IconData suffix = Icons.visibility_outlined;
 void passwordVisibility(){
   password =! password;

   suffix = password ? Icons.visibility_outlined : Icons.visibility_off_outlined;
   emit(PasswordVisibilityChangeState());

 }


}