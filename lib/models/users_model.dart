class UsersModel {
  String UserID = "";
  int datejoined =0;
  String? userInfo;
  List<LikesInteractions>? likes;


  UsersModel({required this.UserID,required this.datejoined, this.userInfo,this.likes});

  UsersModel.fromJson(Map<String,dynamic>json){
    UserID = json["UserID"];
    datejoined = json["datejoined"];
    userInfo = json["userInfo"];
    if(json["likes"]!=null){
      likes = <LikesInteractions>[];
      json["likes"].forEach((v){
        likes!.add(LikesInteractions.fromJson(v));
      });
    }
  }

}


class LikesInteractions {
  String commentID = "";
  int commentDate = 0;
  LikesInteractions({required this.commentID,required this.commentDate});

  LikesInteractions.fromJson(Map<String,dynamic>json){
    commentID = json["commentID"];
    commentDate = json["commentDate"];
  }
}