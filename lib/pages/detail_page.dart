import 'dart:io';
import 'package:firepost/model/post_model.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/rtdb_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/store_service.dart';

class DetailPage extends StatefulWidget {
  static const String id = 'detail_page';

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  addPost() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if (title.isNotEmpty || content.isNotEmpty || _image != null) {
      _apiUploadImage(title, content);
    }
  }

  void _apiUploadImage(String title, String content) {
    setState(() {
      isLoading = true;
    });

    StoreService.uploadImage(_image!).then((imgUrl) => {
          _apiAddpost(title, content, imgUrl!),
        });
    //_apiAddpost(title, content, StoreService.uploadImage(_image!).toString());
  }

  void _apiAddpost(String title, String content, String imgUrl) async {
    String? id = await Prefs.loadUserId();
    Post post =
        Post(userId: id!, title: title, content: content, img_url: imgUrl);

    RTDBService.addPost(post).then((value) => {
          setState(() {
            isLoading = false;
          }),
          Navigator.pushReplacementNamed(context, HomePage.id),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add posts'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _getImage();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: _image != null
                          ? Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset("assets/images/camera_icon.png"),
                    ),
                  ),
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
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
