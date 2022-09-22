import 'package:firepost/pages/detail_page.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/rtdb_service.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Post> items = [];

  //Post post = new Post(userId: '123', title: 'Title1', content: 'Content1');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
    // items.add(post);
    // items.add(post);
    // items.add(post);
  }

  _apiGetPosts() async {
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id!).then((posts) => {
          _reponsePosts(posts),
        });
  }

  _reponsePosts(List<Post> posts) {
    setState(() {
      items.addAll(posts);
    });
  }
  _openDetailPage() {
    Navigator.pushReplacementNamed(context, DetailPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        title: Text('All posts'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, i) {
            return itemOfList(items[i]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openDetailPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget itemOfList(Post item) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            item.content,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }


}
