import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gp/View.dart';
import 'package:gp/Constrains.dart';

class viwes_List extends ChangeNotifier {
  var views = {};
  viwes_List() {
    for (int i = 0; i < KnumOfViews; i++) {
      addView(KviewsSides[i]);
    }
  }

  void addView(String text) {
    views[text] = View(text);
    notifyListeners();
  }

  void updateState(
    bool state,
    String index,
    PlatformFile file,
  ) {
    views[index].state = state;
    views[index].setFile(file);
    notifyListeners();
  }
}
