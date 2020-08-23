import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future showCameraSelection(BuildContext context, Function getImage) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: (context),
      builder: (context) => Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  Text('Camera'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.insert_photo),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  Text('Gallery'),
                ],
              )
            ],
          )));
}
