import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/news_post/news_post_screen.dart';
import 'package:social_app/shared/component/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class  HomeScreen extends StatelessWidget {
    HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit  , SocialAppStates>(
      listener: (context ,state){
        if(state is NewsPostState)
          {
            navigateTo( NewsPostScreen(), context);
          }

      },
      builder: (context ,state){
       AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  Text(
              cubit.titles[cubit.currentIndex],

            ),
            actions: [
              IconButton(onPressed: (){}, icon:const Icon(IconBroken.Search)),
              IconButton(onPressed: (){}, icon:const Icon(IconBroken.Notification)),
            ],
          ),
           body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
           currentIndex:cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);

            },
            items:  const [
              BottomNavigationBarItem(
                  icon:Icon(IconBroken.Home),
                  label: 'Home',

              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Chat),
                label: 'Chat',

              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Paper_Upload),
                label: 'Post',

              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Location),
                label: 'Users',

              ),
              BottomNavigationBarItem(
                icon:Icon(IconBroken.Setting),
                label: 'Settings',

              ),
            ],


          ),


        );
      },
    );
  }
}
