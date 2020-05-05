import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'homepage.dart';


class UploadPhotoPage extends StatefulWidget
{
  State<StatefulWidget> createState()
  {
    return _UploadPhotoPageState();
  }
}


class _UploadPhotoPageState extends State<UploadPhotoPage>
{


  File sampleImage;
  String _myValue;
  String url;
 final formKey = new GlobalKey<FormState>();



  Future getImage() async
  {
    var tempImage = await ImagePicker.pickerImage(source: ImageSource.gallery);

    setState(() {
      sampleImage= tempImage;
    });
  }



  bool valiateAndSave(){

    final form = formKey.currentState;

    if(form.validate())
      {
        form.save()  ;
      return true;
      }
    else
      {
        return false;
      }
  }
  void uploadStatusImage() async
  {
    if(valiateAndSave()) {
      final StorageReference postImageRef = FirebaseStorage.instance.ref()
          .child("Post Image");

      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = postImageRef.child(
          timeKey.toString() = ".jpg").putFile(sampleImage);
      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = ImageUrl.toString();
      print("Image Url = " + url);

      goTohomepage();
      saveToDatabase(url);
    }
      }

      void saveToDataBase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MM d,yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm  aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.formate(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data =
        {
        "image": url ,
        "description": _myValue,
        "date":date,
        "time": time,
      };

      ref.child("Posts").push().set(data);

  }

  void goTohomepage()
  {
    Navigator.push(context,
      MaterialPageRoute(builder: (context)
        {
         return new homepage();
        }
    )
    );
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Images"),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null ? Text("Select an Image"): enableUpload(),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
      tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }


  Widget enableUpload(){

    return Container(
      child: new Form(
      key: formKey,
      child: Column
        (
        children: <Widget>[
          Image.file(sampleImage, height: 310.0, width: 660.0,),
          SizedBox(height: 15.0,)
            TextFormField(
              decoration: new  InputDecoration(labelText: 'Description'),
      validator: (value)
        {
          return value.isEmpty ?'Bold description is required' : null;
        },
    onSaved: (value)
                {
                  return _myValue=value;
                }

            ),

          SizedBox(height: 15.0,),

          RaisedButton(
            elevation: 10.0,
            child: Text("++Post"),
            textColor: Colors.white,
            color: Colors.pink,

            onPressed: uploadStatusImage,
          )
        ],
      ),
      )
    );
  }

}