import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/login/cubit/cubit.dart';
import 'package:social_app/modules/login/cubit/states.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/component/component.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

class  LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  var loginController= PageController();
  var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit , LoginStates>(
        listener: (context , state){
          if(state is LoginSuccessState){
            CacheHelper.saveData(
                key:'uId',
                value:state.uId,
            ).then((value){
          navigateAndRemove(HomeScreen(), context);

            });

          }


        },
        builder: (context , state){
          var cubit = LoginCubit.get(context);

          return  Scaffold(
            appBar: AppBar(


            ),

            body: Center(
              child: SingleChildScrollView(
                padding:const EdgeInsetsDirectional.all(20.0) ,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      const Center(
                        child: Text(
                          'Hello',
                          style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Center(
                        child: Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextFormField(
                        label:'Email',
                        prefixIcon:Icons.email,
                        keyboard: TextInputType.emailAddress,
                        onTap:(){},
                        validate:(String? value){
                          if(value!.isEmpty){
                            return 'Email Address musn\'t be empty';
                          }
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height:15.0,
                      ),
                      defaultTextFormField(
                        label: 'Password',
                        prefixIcon: Icons.lock,
                        keyboard: TextInputType.text,
                        onTap:(){},
                        validate:(String? value){
                          if(value!.isEmpty){

                            return 'password musn\'t be empty';
                          }

                        },
                        controller: passwordController,
                        suffixIcon:cubit.suffix,
                        obscure:cubit.password,
                        suffixPress: (){
                          cubit.passwordVisibility();
                        }

                      ),
                      defaultTextButton(
                        text: 'forgot your password ?',
                        onPress: (){},
                      ),
                      Row(
                        children:  [
                          const Spacer(),
                          const Text(
                            'Sign in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Container(

                            padding: const EdgeInsets.all(3.0),
                            decoration:   BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30.0),

                              color: Colors.blue,
                            ),
                            child: ConditionalBuilder(
                              condition: state is! LoadingLoginState,
                              builder:(context)=> IconButton(
                                onPressed:(){
                                  if(formKey.currentState!.validate()){
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                    );

                                  }

                                },
                                icon:const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,

                                ),
                              ),
                              fallback: (context)=>const Center(child: CircularProgressIndicator()),
                            ),
                          ),


                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Text(
                            'Don\'t have an account ?',
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          defaultTextButton(
                            onPress: (){
                           Navigator.push(
                               context,
                               MaterialPageRoute(builder:(context)=>RegisterScreen()),
                           );

                            },
                            text: 'Create',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ],
                      ),



                    ],

                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
