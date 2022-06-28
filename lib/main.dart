import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:gp/viwes_list.dart';
import 'package:open_file/open_file.dart';
import 'package:gp/viwes_list.dart';
import 'package:provider/provider.dart';
import 'package:gp/View.dart';
import 'package:gp/Constrains.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: imageUploader(),
      ),
      create: (_) => viwes_List(),
    );
  }
}

class imageUploader extends StatefulWidget {
  const imageUploader({Key? key}) : super(key: key);

  @override
  State<imageUploader> createState() => _imageUploaderState();
}

class _imageUploaderState extends State<imageUploader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("file picker"),
          centerTitle: true,
        ),
        body: Center(
          child: GridView.builder(
              padding: EdgeInsets.all(250),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemCount: Provider.of<viwes_List>(context).views.length,
              itemBuilder: (context, index) {
                String k = Provider.of<viwes_List>(context)
                    .views
                    .keys
                    .elementAt(index);
                return ImgUploader(Provider.of<viwes_List>(context).views[k]);
              }),
        ));
  }

/*void openFiles(List<PlatformFile> files, context) =>
    Navigator.of((context)).push(MaterialPageRoute(
        builder: (context) => FilesPage(files: files, onOpendFile: openfile)));

void openfile(PlatformFile file) {
  OpenFile.open(file.path);
}*/

/*Uint8List imagevalue = Uint8List(4);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                'Mah Links',
                style: TextStyle(
                  fontFamily: 'Karla',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
                // child: imagevalue == null
                child: Text('No Image'))
            //   : Image.memory(imagevalue))
            //: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: Image.memory(imagevalue).image)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'picker',
        elevation: 0,
        backgroundColor: Colors.tealAccent[400],
        hoverElevation: 0,
        label: Row(
          children: <Widget>[
            Icon(Icons.file_upload),
            SizedBox(width: 10),
            Text('Upload Image')
          ],
        ),
        onPressed: () => uploadImage(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        imagevalue = file.bytes!;
      });
    } else {
      // User canceled the picker
    }
  }
}*/
/* constraints: const BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text("pick image "),
          onPressed: () async {
            final res = await FilePicker.platform.pickFiles(
              allowMultiple: true,
              withData: true,
              type: FileType.image,
            );
            if (res == null) return;
            print(res.files.first.bytes);
            openFiles(res.files, context);
          },
        ),*/
}

class ImgUploader extends StatelessWidget {
  final View view;
  ImgUploader(this.view);
  Widget buildFile(context) {
    return InkWell(
      onTap: () async {
        final res = await FilePicker.platform.pickFiles(
          withData: true,
          type: FileType.image,
        );
        if (res == null) return;
        Provider.of<viwes_List>(context, listen: false)
            .updateState(true, view.side, res.files.first);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${view.side}"),
            Expanded(
              child: Container(
                  child: view.state
                      ? Ink.image(
                          image: Provider.of<viwes_List>(context)
                              .views[view.side]
                              .image)
                      : Center(
                          child: Text(
                          "Click Here to upload",
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        ))),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildFile(context);
  }
}
