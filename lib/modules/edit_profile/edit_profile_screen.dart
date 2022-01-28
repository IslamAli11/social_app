import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/component/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        File? profileImage = AppCubit.get(context).profileImage;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        var coverImage = AppCubit.get(context).coverImage;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5.0,
            title: const Text('Edit Profile'),
            actions: [
              defaultTextButton(
                  onPress: () {
                    AppCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'UPDATE',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              const SizedBox(
                width: 10.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[400],
                                  child: IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).getCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      size: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.blue[400],
                                child: IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if(AppCubit.get(context).profileImage !=null ||AppCubit.get(context).coverImage!=null )
                  Row(
                    children: [
                      if(AppCubit.get(context).profileImage !=null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: 'UPLOAD PROFILE', onPress: () {
                                    AppCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                    );
                              }
                                  ),
                              if (state is UpdateUserLoadingState)
                              const SizedBox(
                                height: 3.0,
                              ),
                              if (state is UpdateUserLoadingState)
                              const LinearProgressIndicator(
                                minHeight: 5.0,
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if(AppCubit.get(context).coverImage!=null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: 'UPLOAD COVER', onPress: () {
                                    AppCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                         phone: phoneController.text,
                                        bio: bioController.text
                                    );

                              }
                                  ),
                              if (state is UpdateUserLoadingState)
                              const SizedBox(
                                height: 3.0,
                              ),
                              if (state is UpdateUserLoadingState)
                              const LinearProgressIndicator(
                                minHeight: 5.0,
                              ),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    label: 'Name',
                    prefixIcon: IconBroken.User,
                    keyboard: TextInputType.name,
                    onTap: () {},
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name mus\'t be empty';
                      }
                    },
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    label: ' bio',
                    prefixIcon: IconBroken.Info_Circle,
                    keyboard: TextInputType.text,
                    onTap: () {},
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio mus\'t be empty';
                      }
                    },
                    controller: bioController,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    label: 'phone',
                    prefixIcon: IconBroken.Call,
                    keyboard: TextInputType.phone,
                    onTap: () {},
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone number mus\'t be empty';
                      }
                    },
                    controller: phoneController,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
