import 'package:firepost/model/post_model.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/rtdb_service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static const String id = 'detail_page';

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add posts'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'Content',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 45,
                color: Colors.green,
                child: TextButton(
                  onPressed: () {
                    addPost();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addPost() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();

    String? id = await Prefs.loadUserId();
    Post post = new Post(userId: id!, title: title, content: content);

    RTDBService.addPost(post).then((value) => {
      _afterAddPost(),
        });
  }
  _afterAddPost(){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

}
