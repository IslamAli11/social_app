 abstract class SocialAppStates{}

 class InitialState extends SocialAppStates{}


 class LoadingGetUserState extends SocialAppStates{}
 class GetUserSuccessState extends SocialAppStates{}
 class GetUserErrorState extends SocialAppStates{
  final String error;
  GetUserErrorState(this.error);


 }


 class LoadingGetPostState extends SocialAppStates{}
 class GetPostSuccessState extends SocialAppStates{}
 class GetPostErrorState extends SocialAppStates{
  final String error;
  GetPostErrorState(this.error);


 }


 class LikePostSuccessState extends SocialAppStates{}
 class LikePostErrorState extends SocialAppStates{
  final String error;
  LikePostErrorState(this.error);


 }


 class CommentPostSuccessState extends SocialAppStates{}
 class CommentPostErrorState extends SocialAppStates{
  final String error;
  CommentPostErrorState(this.error);


 }



 class ChangeBottomNavState extends SocialAppStates{}

 class NewsPostState extends SocialAppStates{}



 class ProfileImageSuccessState extends SocialAppStates{}
 class ProfileImageErrorState extends SocialAppStates{}



 class CoverImageSuccessState extends SocialAppStates{}
 class CoverImageErrorState extends SocialAppStates{}



 class UploadProfileImageSuccessState extends SocialAppStates{}
 class UploadProfileImageErrorState extends SocialAppStates{}


 class UploadCoverImageSuccessState extends SocialAppStates{}
 class UploadCoverImageErrorState extends SocialAppStates{}


 class UpdateUserErrorState extends SocialAppStates{}
 class UpdateUserLoadingState extends SocialAppStates{}


 class PostImageSuccessState extends SocialAppStates{}

 class PostImageErrorState extends SocialAppStates{}

 class CreatePostLoadingState extends SocialAppStates{}

 class CreatePostSuccessState extends SocialAppStates{}

 class CreatePostErrorState extends SocialAppStates{}

 class UploadCreatePostImageSuccessState extends SocialAppStates{}

 class UploadCreatePostImageErrorState extends SocialAppStates{}

 class RemovePostImageSuccessState extends SocialAppStates{}

 class SendMessageSuccessState extends SocialAppStates{}
 class SendMessageErrorState extends SocialAppStates{}


 class GetMessageSuccessState extends SocialAppStates{}
 class GetMessageErrorState extends SocialAppStates{}

