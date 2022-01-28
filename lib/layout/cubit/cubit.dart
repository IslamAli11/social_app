import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model/post_model.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/modules/chat/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/news_post/news_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/component/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<SocialAppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  int currentIndex = 0;

  void getUserData() async {
    emit(LoadingGetUserState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.email);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<UserModel> users = [];

  void getUsers() {
    if (users.length ==0)
    {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId'] != userModel!.uId)
          users.add(UserModel.fromJson(element.data()));
        });
      }).catchError((error) {});
    }
  }

  void getPosts() {
    emit(LoadingGetPostState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        });

        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(GetPostSuccessState());
    }).catchError((error) {
      emit(GetPostErrorState(error.toString()));
    });
  }

  List<Widget> screen = [
    const NewsFeeds(),
    const ChatScreen(),
    NewsPostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Setting',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(NewsPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavState());
    }
  }

  File? profileImage;
  File? coverImage;

  ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      emit(ProfileImageSuccessState());
    } else {
      emit(ProfileImageErrorState());

      print('no image selected');
    }
  }

  Future<void> getCoverImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      emit(CoverImageSuccessState());
    } else {
      emit(CoverImageErrorState());

      print('no image selected');
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(UpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      uId: userModel!.uId,
      bio: bio,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserErrorState());
    });
  }

  File? postImage;

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageSuccessState());
  }

  Future<void> getPostImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      emit(PostImageSuccessState());
    } else {
      emit(PostImageErrorState());

      print('no image selected');
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(UploadCreatePostImageErrorState());
      });
    }).catchError((error) {
      emit(UploadCreatePostImageErrorState());
    });
  }

  void createNewPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  void commentPost({
    required String commentId,
    required String dateTime,
    required String text,
  }) {
    CommentModel model = CommentModel(
        name: userModel!.name,
        uId: userModel!.uId,
        dateTime: dateTime,
        text: text);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(commentId)
        .collection('comments')
        .doc(userModel!.uId)
        .set(model.toMap())
        .then((value) {
      emit(CommentPostSuccessState());
    }).catchError((error) {
      emit(CommentPostErrorState(error.toString()));
    });
  }


  void sendMessage({
    required String text,
    required String receiverUId,
    String? senderUId,
    required String dateTime,

}){

    MessageModel model = MessageModel(
      senderId: userModel!.uId,
        receiverId: receiverUId,
        dateTime: dateTime,
        text: text
    );

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverUId)
        .collection('message')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(receiverUId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value){
      emit(GetMessageSuccessState());
    })
        .catchError((error){
      emit(GetMessageErrorState());
    });


  }


 List<MessageModel> messages =[];

  void getMessage({
  required String receiverId,
}){

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
             messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));

          });
             emit(GetMessageSuccessState());

    });
  }



}
