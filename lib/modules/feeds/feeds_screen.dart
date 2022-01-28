
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class  NewsFeeds extends StatelessWidget {
  const  NewsFeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit , SocialAppStates>(
     listener: (context , state){},
      builder: (context , state){

       return ConditionalBuilder(
       condition:AppCubit.get(context).posts.isNotEmpty && AppCubit.get(context).userModel !=null ,
       builder:(context)=> SingleChildScrollView(
         child: Column(
           children:  [
             Card(
               child: Stack(
                 alignment: AlignmentDirectional.bottomEnd,
                 children:  [
                   const Image(
                     image: NetworkImage('https://image.freepik.com/free-photo/winter-holidays-people-concept-cute-teen-girl-with-red-hair-smiling-pointing-fingers-sideways-showing-advertisements-standing-blue-background_1258-55293.jpg'),
                     height: 200.0,
                     width: double.infinity,
                     fit: BoxFit.cover,


                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text(
                       'Communicate with friends',
                       style: Theme.of(context).textTheme.subtitle1!.copyWith(
                         fontWeight: FontWeight.bold,

                       ),

                     ),
                   ),
                 ],
               ),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               elevation: 5.0,
               margin: const EdgeInsets.all(8.0),
             ),
             ListView.separated(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder:(context , index)=>buildPostItem(context , AppCubit.get(context).posts[index] , index),
               separatorBuilder:(context , index)=>const SizedBox(
                 height: 5.0,
               ),
               itemCount: AppCubit.get(context).posts.length,
             ),
             const SizedBox(
               height: 5.0,
             ),

           ],
         ),
       ) ,
       fallback: (context)=>const Center(child: CircularProgressIndicator()),
       );
      },
    );
  }
}

Widget buildPostItem(context ,PostModel model , index )=> Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 10.0,
  margin: const EdgeInsets.symmetric(horizontal: 8.0),

  child:Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(

          children:  [
             CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(model.image),

            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Row(
                    children: [
                      Text(
                          model.name,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Icon(
                        Icons.check_circle,
                        size: 16.0,
                        color: Colors.blue,

                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    model.dateTime,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: (){},
              icon:const Icon(
              Icons.more_horiz,
              size: 16.0,
            ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
         Text(
          model.text,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //     bottom: 5.0
        //   ),
        //   child: Container(
        //     width: double.infinity,
        //     height: 25.0,
        //     child: Wrap(
        //       children: [
        //         Container(
        //           height: 25.0,
        //           child: MaterialButton(
        //             minWidth: 1.0,
        //             height: 25.0,
        //             onPressed:(){},
        //             child: const Text(
        //               '#software',
        //               style: TextStyle(
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 25.0,
        //           child: MaterialButton(
        //             minWidth: 1.0,
        //             height: 25.0,
        //             onPressed:(){},
        //             child: const Text(
        //               '#software',
        //               style: TextStyle(
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 25.0,
        //           child: MaterialButton(
        //             minWidth: 1.0,
        //             height: 25.0,
        //             onPressed:(){},
        //             child: const Text(
        //               '#software',
        //               style: TextStyle(
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 25.0,
        //           child: MaterialButton(
        //             minWidth: 1.0,
        //             height: 25.0,
        //             onPressed:(){},
        //             child: const Text(
        //               '#software',
        //               style: TextStyle(
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 25.0,
        //           child: MaterialButton(
        //             minWidth: 1.0,
        //             height: 25.0,
        //             onPressed:(){},
        //             child: const Text(
        //               '#software',
        //               style: TextStyle(
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Container(
        //           height: 25.0,
        //           child: MaterialButton(
        //             minWidth: 1.0,
        //             height: 25.0,
        //             onPressed:(){},
        //             child: const Text(
        //               '#software',
        //               style: TextStyle(
        //                 color: Colors.blue,
        //               ),
        //             ),
        //           ),
        //         ),
        //
        //       ],
        //     ),
        //   ),
        // ),
        if(model.postImage!='')
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Container(
            width: double.infinity,
            height: 150.0,
            decoration:   BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image:  DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(model.postImage),

              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){},

                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 16.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${AppCubit.get(context).likes[index]}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconBroken.Chat,
                        size: 16.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '0 comments',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: InkWell(
            onTap: (){


            },
            child: Row(

              children:  [
                 CircleAvatar(
                  radius: 18.0,
                  backgroundImage: NetworkImage(AppCubit.get(context).userModel!.image),

                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                      'Write comment....',
                      style:
                      Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16.0,
                      )
                  ),
                ),
                InkWell(
                  onTap: (){
                    AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);

                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        size: 16.0,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),



      ],
    ),
  ),

);
