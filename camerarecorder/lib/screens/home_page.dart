import 'dart:io';

import 'package:camerarecorder/models/image_model.dart';
import 'package:camerarecorder/screens/image_view.dart';
import 'package:flutter/material.dart';

import 'camera_module.dart';

List<Imagemodel> imagesList = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white60,
          title: Text(
            "Gallery",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: imagesList.length == 0
            ? emptyGalleryViewBody()
            : galleryGridViewBody(),
        floatingActionButton:
            imagesList.length == 0 ? Container() : floaterBtnBody());
  }

  Widget emptyGalleryViewBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) => CameraModule()));
            },
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
              height: 100,
              width: 100,
              child: const Icon(
                Icons.add_a_photo,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "No photos",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) => CameraModule()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "Click to take photo",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget galleryGridViewBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        children: List.generate(imagesList.length, (index) {
          return InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => Imageview(
                          imagemodel: Imagemodel(
                              imagePath: imagesList[index].imagePath,
                              imageName: imagesList[index].imageName))));
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Image.file(
                      File(imagesList[index].imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        imagesList[index].imageName.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget floaterBtnBody() {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
      height: 100,
      width: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => CameraModule()));
        },
        child: const Icon(
          Icons.add_a_photo,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
