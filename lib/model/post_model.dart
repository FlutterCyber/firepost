class Post {
  late String userId;
  late String title;
  late String content;

  Post(
      {required String userId,
      required String title,
      required String content}) {
    this.userId = userId;
    this.title = title;
    this.content = content;
  }

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        title = json['title'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'content': content,
      };
}
