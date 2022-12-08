import 'dart:io';

import 'package:camerarecorder/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Imageview extends StatefulWidget {
  Imageview({Key? key, required this.imagemodel}) : super(key: key);
  Imagemodel? imagemodel;
  @override
  _ImageviewState createState() => _ImageviewState();
}

class _ImageviewState extends State<Imageview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
        backgroundColor: Colors.white60,
        title: Text(
          widget.imagemodel!.imageName,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Stack(
      children: [
        Container(
          child: PhotoView(
            imageProvider: FileImage(File(widget.imagemodel!.imagePath)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.black38,
                radius: 17.5,
                child: Icon(
                  Icons.close_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
