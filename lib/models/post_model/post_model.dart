class PostModel{
  late String name;
  late String uId;
  late String image;
  late String text;
  late String postImage;
  late String dateTime;
  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.text,
    required this.postImage,
    required this.dateTime,
  });
  PostModel.fromJson(Map<String  , dynamic>json){
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    text =json['text'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];

  }

  Map<String , dynamic> toMap(){

    return {
      'name' :name,
      'uId' : uId,
      'image' : image,
      'text' : text,
      'postImage' : postImage,
      'dateTime' : dateTime,

    };
  }

}