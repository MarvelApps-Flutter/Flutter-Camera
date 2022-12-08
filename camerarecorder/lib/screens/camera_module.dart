import 'dart:math';

import 'package:camera/camera.dart';
import 'package:camerarecorder/models/image_model.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

List<CameraDescription> cameras = [];

class CameraModule extends StatefulWidget {
  const CameraModule({Key? key}) : super(key: key);

  @override
  _CameraModuleState createState() => _CameraModuleState();
}

class _CameraModuleState extends State<CameraModule> {
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;
  late CameraController _cameraController;
  late Future<void> cameraValue;
  @override
  void initState() {
    super.initState();
    if (cameras.length != 0) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.high);
      cameraValue = _cameraController.initialize();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          cameraModuleBottomBar()
        ],
      ),
    );
  }

  Widget cameraModuleBottomBar() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(
                      flash ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        flash = !flash;
                      });
                      flash
                          ? _cameraController.setFlashMode(FlashMode.torch)
                          : _cameraController.setFlashMode(FlashMode.off);
                    }),
                GestureDetector(
                  onTap: () async {
                    takePhoto(context);
                  },
                  child: Icon(
                    Icons.panorama_fish_eye,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
                IconButton(
                    icon: Transform.rotate(
                      angle: transform,
                      child: Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        iscamerafront = !iscamerafront;
                        transform = transform + pi;
                      });
                      int cameraPos = iscamerafront ? 0 : 1;
                      _cameraController = CameraController(
                          cameras[cameraPos], ResolutionPreset.high);
                      cameraValue = _cameraController.initialize();
                    }),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Tap for camera",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();

    imagesList.add(Imagemodel(
        imageName: file.name.toString(), imagePath: file.path.toString()));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (builder) => HomePage()));
  }
}
