import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:pfe/NetworkHandler.dart';

import 'AccueilEtd.dart';

class importerCV extends StatefulWidget {
  const importerCV({ Key? key }) : super(key: key);

  @override
  State<importerCV> createState() => _importerCVState();
}

class _importerCVState extends State<importerCV> {
  bool AlertError=false;
  late File filePdf;
  bool circular = false;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            imageProfile(),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 230,
              color: Color.fromARGB(255, 73, 130, 183),
              child: GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children:[
                      const Icon(Icons.cloud_upload,size: 80,color: Colors.white,),
                      const Text('choisir un CV pdf',
                      style: TextStyle(
                        color: Colors.white, fontSize: 24
                      )),
                  const SizedBox(
                  height: 10,
                  ),
                  ElevatedButton (
                 style: ElevatedButton.styleFrom(
                 padding: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
                 primary: Colors.blue.shade300,
                 shape: RoundedRectangleBorder(),
                  ),
                  child: const Text("Valider",style: TextStyle( color: Colors.white,fontSize: 20)),
                  onPressed: ()async {
                        if(_imageFile?.path != null && filePdf.path!=null) {
                          var CVResponse = await networkHandler.postCV(
                              "/cv/add/pdf", filePdf.path);
                          if (CVResponse.statusCode == 200) {          
                            var imageResponse = await networkHandler.patchImage(
                              "/cv/add/image", _imageFile!.path);
                          if (imageResponse.statusCode == 200) {
                            setState(() {
                              circular = false;
                              AlertError=false;
                            });
                        
                            _showDialog(context,"la procédure d'inscription est terminé avec succée.\nBienvenue dans Sattegeny",AlertError);
                            
                          }
                          else{
                            print('image error');
                          }
                          }else{
                            print('CV PDF error');
                          }
                          }else{
                            setState(() {
                            AlertError=true;
                           });
                             _showDialog(context,"Vueillez ajouter une photo de profile et imporer votre CV",AlertError);
                          }
                          }
            ),
                    ]
                  ),
                ),
                onTap: ()async{
                  
                  FilePickerResult result = await FilePicker.platform.pickFiles();
                  if (result == null){
                    print('error1');}
                  else{
                  print('ok');
                  File file = File(result.files.single.path);
                  setState(() {
                    filePdf=file;
                  });
                  }
                },
              ),
            ),

          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
         openFile(filePdf.path);
        }, 
        label: const Text('Aperçu'),
        icon: const Icon(Icons.content_paste_search_rounded),
        backgroundColor: Colors.blue.shade300,
      ),
    );
  }
  static Future openFile(String url) async {
    await OpenFile.open(url);
  }
    Widget imageProfile() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: _imageFile == null
              ? const AssetImage('assets/images/avatar.png')
              : FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(Icons.camera_alt, color: Colors.black45, size: 28),
          ),
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickerFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickerFile;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            'choisir une photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

 _showDialog(BuildContext context,String text,bool Error){
  showDialog(
      context: context,
      builder: (BuildContext context){ 
         return CupertinoAlertDialog(
        title: Column(
          children: <Widget>[
            Text(text),
            
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              if(Error==true) {
                Navigator.of(context).pop();
              } else {
                Navigator.pushNamed(context,'/AccueilEtd');
              } 
            },),
        ],
      );
       });
}

}
