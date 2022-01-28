
 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class  ChatDetailsScreen extends StatelessWidget {
   UserModel userModel;
    ChatDetailsScreen({Key? key,  required this.userModel}) : super(key: key) ;
   var messageController = TextEditingController();



   @override
   Widget build(BuildContext context) {

     AppCubit.get(context).getMessage(receiverId:userModel.uId);
     return Builder(
       builder: (context){

         return BlocConsumer<AppCubit , SocialAppStates>(
           listener: (context , state){},
           builder: (context , state){
             return Scaffold(
               appBar: AppBar(
                 titleSpacing: 0.0,
                 title: Row(
                   children:  [
                     CircleAvatar(
                       radius: 20.0,
                       backgroundImage: NetworkImage(userModel.image),

                     ),
                     const SizedBox(
                       width: 15.0,
                     ),
                     Text(
                         userModel.name
                     )
                   ],
                 ),
               ),
               body:Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Column(
                   children: [
                     Expanded(
                       child: ListView.separated(
                         shrinkWrap: false,
                       //physics: const NeverScrollableScrollPhysics(),
                         itemBuilder:(context , index){
                           var message = AppCubit.get(context).messages[index];
                           if(AppCubit.get(context).userModel!.uId == message.senderId)
                           return buildSenderMessage(message);
                           return buildReceiverMessage(message);
                         },
                         separatorBuilder:(context  , index)=>const SizedBox(
                           height: 15.0,
                         ),
                         itemCount: AppCubit.get(context).messages.length,
                       ),
                     ),
                     SizedBox(
                       height: 6.0,
                     ),

                     Container(
                       padding: const EdgeInsets.symmetric(
                           horizontal: 10.0
                       ),
                       decoration: BoxDecoration(

                           borderRadius: BorderRadiusDirectional.circular(10.0),
                           border: Border.all(
                               color: Colors.grey
                           )
                       ),
                       child: Row(
                         children: [
                           Expanded(
                             child: TextFormField(
                               controller:  messageController,
                               keyboardType: TextInputType.text,
                               decoration: const InputDecoration(
                                 hintText: 'send your message ...',
                                 border: InputBorder.none,

                               ),
                             ),
                           ),
                           IconButton(
                             onPressed: (){

                               AppCubit.get(context).sendMessage(
                                 text:messageController.text,
                                 receiverUId:userModel.uId,
                                 dateTime: DateTime.now().toString(),
                               );
                             },
                             icon: const Icon(
                               Icons.send,
                               color: Colors.blue,
                               size: 30.0,
                             ),
                           )

                         ],
                       ),
                     ),

                   ],
                 ),
               ),
             );
           },
         );
       },
     );
   }





   Widget buildReceiverMessage(MessageModel model)=>Align(
     alignment: AlignmentDirectional.centerStart,
     child: Container(

         padding: const EdgeInsets.symmetric(
           vertical: 5.0,
           horizontal: 15.0,
         ),
         decoration:  BoxDecoration(
           color: Colors.grey[300],
           borderRadius: const BorderRadiusDirectional.only(
               topStart: Radius.circular(10.0),
               topEnd: Radius.circular(10.0),
               bottomEnd: Radius.circular(10.0)
           ),

         ),
         child:  Text(
           model.text,
           style: const TextStyle(
             fontSize: 22.0,

           ),
         )
     ),
   );
   Widget buildSenderMessage(MessageModel model)=>Align(
     alignment: AlignmentDirectional.centerEnd,
     child: Container(

         padding: const EdgeInsets.symmetric(
           vertical: 5.0,
           horizontal: 10.0,
         ),
         decoration:  BoxDecoration(
           color: Colors.blue[100],
           borderRadius: const BorderRadiusDirectional.only(
               topStart: Radius.circular(10.0),
               topEnd: Radius.circular(10.0),
               bottomStart: Radius.circular(10.0)
           ),

         ),
         child:  Text(
         model.text,
           style: const TextStyle(
             fontSize: 22.0,

           ),
         )
     ),
   );
 }
