 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/chatdetails/chat_details_screen.dart';
import 'package:social_app/shared/component/component.dart';

class  ChatScreen extends StatelessWidget {
   const  ChatScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return  BlocConsumer<AppCubit , SocialAppStates>(
      listener: (context ,state){},
       builder: (context , state){
        return  ConditionalBuilder(
        condition:AppCubit.get(context).users.length >0 ,
          builder: (context)=> ListView.separated(
              itemBuilder:(context , index)=>buildChatItem(AppCubit.get(context).users[index] ,context),
              separatorBuilder:(context , index)=>  Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount:AppCubit.get(context).users.length,
          ),
          fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
        );
       },
     );


   }


   Widget buildChatItem(UserModel model, context)=>InkWell(
     onTap: (){
       navigateTo(ChatDetailsScreen(userModel: model), context);
     },
     child: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Row(

         children:  [
            CircleAvatar(
             radius: 25.0,
             backgroundImage: NetworkImage(model.image),

           ),
           const SizedBox(
             width: 10.0,
           ),
           Text(
               model.name,
               style: Theme.of(context).textTheme.bodyText1!.copyWith(
                 fontWeight: FontWeight.bold,
                 fontSize: 16.0,
               )
           ),

         ],
       ),
     ),
   );

 }
