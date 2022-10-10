class Post {
  late String userId;
  late String title;
  late String content;
  late String img_url;

  Post(
      {required String userId,
      required String title,
      required String content,
      required String img_url}) {
    this.userId = userId;
    this.title = title;
    this.content = content;
    this.img_url = img_url;
  }

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        title = json['title'],
        content = json['content'],
        img_url = json['img_url'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'content': content,
        'img_url': img_url,
      };
}
