import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  UserCredential? userCredential;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    print('hello');

    emit(LoadingRegisterState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,


      );
    }).catchError((error) {
      emit(ErrorRegisterState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
     String? image,
     String? bio,
     String? cover,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: '"https://i.stack.imgur.com/l60Hf.png',
      cover: "http://www.aquisana-serre-chevalier.fr/images/joomlart/demo/default.jpg",
      bio: 'write your bio ...',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(SuccessUserCreateState());
    })
        .catchError((error) {
      print(error.toString());
      emit(ErrorUserCreateState(error.toString()));
    });
  }

  bool obscure=true;
  IconData suffix = Icons.visibility_outlined;
  void eyeChange(){
    obscure = !obscure;
    suffix = obscure? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(EyeChangeState());


  }

}
