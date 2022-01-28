 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/component/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewsPostScreen extends StatelessWidget {
    NewsPostScreen({Key? key}) : super(key: key);

   var textController = TextEditingController();

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<AppCubit , SocialAppStates>(
       listener: (context , state){},
       builder: (context , state){
         return Scaffold(
           appBar: AppBar(
             title: const Text('Create Post'),
             actions: [
               defaultTextButton(

                 onPress: (){
                   var now = DateTime.now();
                   if(    AppCubit.get(context).postImage ==null){

                     AppCubit.get(context).createNewPost(
                         text: textController.text,
                         dateTime: now.toString(),
                     );
                   }else
                     {
                       AppCubit.get(context).uploadPostImage(
                           dateTime: now.toString(),
                           text: textController.text,
                       );
                     }


                 },
                 text: 'POST',
                 fontSize: 16.0,
                 fontWeight: FontWeight.bold,
               )
             ],
           ),
           body: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               children:  [
                 if(state is CreatePostLoadingState)
                   const LinearProgressIndicator(),
                 if(state is CreatePostLoadingState)
                   const SizedBox(
                     height: 5.0,
                   ),
                 Row(
                   children:  [
                     const CircleAvatar(
                       radius: 25.0,
                       backgroundImage: NetworkImage('https://image.freepik.com/free-photo/brr-how-freezing-there-young-woman-cuddles-feels-cold-asks-turn-heater-wears-knitted-hat-warm-scarf-around-neck-walks-during-frozing-winter-day-shivers-isolated-blue-background_273609-57032.jpg'),

                     ),
                     const SizedBox(
                       width: 10.0,
                     ),
                     Text(
                         'Eslam Ali',
                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
                           fontWeight: FontWeight.bold,
                           fontSize: 16.0,
                         )
                     ),


                   ],
                 ),
                 const SizedBox(
                   height: 40.0,
                 ),
                 Expanded(
                   child: TextFormField(
                     controller: textController,
                     decoration: const InputDecoration(
                       border: InputBorder.none,
                       hintText: 'what in your mind ..',



                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 10.0,
                 ),
                 if(AppCubit.get(context).postImage != null)
                   Stack(
                     alignment: AlignmentDirectional.topEnd,
                     children: [
                       Container(
                         width: double.infinity,
                         height: 160.0,
                         decoration: BoxDecoration(
                           borderRadius:  BorderRadius.circular(
                       5.0
                           ),
                           image: DecorationImage(
                               fit: BoxFit.cover,
                             image: FileImage(AppCubit.get(context).postImage!),

                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: CircleAvatar(
                           backgroundColor: Colors.blue[400],
                           child: IconButton(
                             onPressed: () {
                               AppCubit.get(context).removePostImage();
                             },
                             icon: const Icon(
                               Icons.close,
                               size: 18.0,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       )
                     ],
                   ),
                 const SizedBox(
                   height: 20.0,
                 ),
                 Row(

                   children: [
                     Expanded(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:  [
                           TextButton(
                             onPressed: (){
                              AppCubit.get(context).getPostImage();
                             },
                             child:Row(
                               children: const [
                                 Icon(IconBroken.Image),
                                 SizedBox(
                                   width: 4.0,
                                 ),
                                 Text('Add Photo'),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                     Expanded(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children:  [
                           TextButton(
                             onPressed: (){},
                             child:const Text('# hachtage'),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         );
       },
     );
   }
 }
