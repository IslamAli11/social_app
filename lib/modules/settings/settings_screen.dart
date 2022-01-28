 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/component/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class  SettingScreen extends StatelessWidget {
   const  SettingScreen({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return  BlocConsumer<AppCubit , SocialAppStates>(
    listener: (context , state){},
       builder: (context ,state){
      var userModel = AppCubit.get(context).userModel;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 190.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,

                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 160.0,
                      decoration:     BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            userModel!.cover
                              ),

                        ),
                      ),
                    ),
                  ),
                   CircleAvatar(
                    radius:64.0 ,
                    backgroundColor:Colors.white,
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                        userModel.image
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              userModel.name,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              userModel.bio,
              style:Theme.of(context).textTheme.caption,

            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2
                          ),
                          Text(
                            'post ',
                            style:Theme.of(context).textTheme.caption,

                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2
                          ),
                          Text(
                            'post ',
                            style:Theme.of(context).textTheme.caption,

                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2
                          ),
                          Text(
                            'post ',
                            style:Theme.of(context).textTheme.caption,

                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2
                          ),
                          Text(
                            'post ',
                            style:Theme.of(context).textTheme.caption,

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: (){},
                      child:const Text(
                        'Edit profile'
                      ),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                OutlinedButton(
                  onPressed: (){
                    navigateTo( EditProfileScreen(), context);
                  },
                  child:const Icon(IconBroken.Edit),
                ),
              ],
            ),
          ],
        ),
      );
       },
     );

   }
 }
