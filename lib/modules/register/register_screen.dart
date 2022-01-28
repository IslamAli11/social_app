

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_screen.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/component/component.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();
   var formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit , RegisterStates>(
        listener: (context , state){},
        builder: (context , state){
          var cubit = RegisterCubit.get(context);
          return  Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text(
                          'Create account',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        defaultTextFormField(
                          label: 'User Name',
                          prefixIcon: Icons.person,
                          keyboard: TextInputType.name,
                          onTap:(){},
                          validate:(String? value){
                            if(value!.isEmpty){

                              return 'user name musn\'t be empty';
                            }

                          },
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          label: 'Email',
                          prefixIcon:Icons.email,
                          keyboard: TextInputType.emailAddress,
                          onTap:(){},
                          validate:(String? value){
                            if(value!.isEmpty){
                              return'email address musn\'t be empty';
                            }


                          },
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          label: 'Password',
                          prefixIcon: Icons.lock,
                          keyboard: TextInputType.text,
                          onTap:(){},
                          validate:(String? value){
                            if(value!.isEmpty){

                              return'password musn\'t be empty';
                            }
                          },
                          controller: passwordController,
                            obscure: cubit.obscure,
                            suffixIcon:cubit.suffix,

                          suffixPress: (){
                           cubit.eyeChange();
                          }
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          label: 'Mobile',
                          prefixIcon: Icons.phone,
                          keyboard:TextInputType.number ,
                          onTap:(){},
                          validate:(String? value) {
                            if (value!.isEmpty) {
                              return 'phone number musn\'t be empty';
                            }
                          },
                          controller:phoneController,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            const Text(
                              'Create',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(

                              padding:  const EdgeInsets.all(1.0),
                              decoration:   BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30.0),

                                color: Colors.blue,
                              ),
                              child: IconButton(
                                onPressed:(){
                                  if(formkey.currentState!.validate()){
                                 cubit.userRegister(
                                    name: nameController.text,
                                     email: emailController.text,
                                     password: passwordController.text,
                                     phone: phoneController.text,
                                 );

                                 navigateTo(
                                      HomeScreen(),
                                     context
                                 );

                                  }

                                },
                                icon:const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,

                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
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
