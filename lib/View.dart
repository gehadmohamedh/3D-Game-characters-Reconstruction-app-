import 'package:flutter/cupertino.dart';
//import 'package:image/image.dart';
import 'package:flutter/material.dart';
import 'package:gp/Constrains.dart';
import 'package:file_picker/file_picker.dart';

class View {
  View(this.side);
  bool state = false;
  String side = "";

  late ImageProvider image;

  late PlatformFile file;

  late double size;
  late String extension;

  void setImage() {
    image = MemoryImage(file.bytes!);
    image = ResizeImage(image, width: KimageWidth, height: Kimagehight);
  }

  void setFile(PlatformFile file) {
    this.file = file;
    size = ((file.size / 1024) / 1024);
    extension = file.extension ?? 'none';
    setImage();
  }
}
