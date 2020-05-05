import 'package:flutter/material.dart';
import 'package:flutter_blog_app/PhotoUpload.dart';
import 'Authentication.dart';
import 'PhotoUpload.dart';
import 'posts.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget
{

  homepage
      (
  {
    this.auth,
    this.onSignedOut,
}
      )
  final AuthImplementation auth;
  final VoidCallback onSignedOut;


  @override
  State<StatefulWidget>createState()
  {
    return _HomePageState();
  }
}

 class _HomePageState extends State<HomePage>
 {
   List<Posts> postList = [];
    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference postsref = FirebaseDatabase.instance.reference().child("Posts")

    postsRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postList.clear();

      for(var individualKey in KEYS )
        {
          Posts posts: new Posts(
            DATA[individualKey]['image'],
            DATA[individualKey]['description'],
            DATA[individualKey]['date'],
            DATA[individualKey]['time'],
          );

          postList.add(posts);
        }


      setState(() {
        print('Length: $postsList.length');
      });
    }
    );
  }



   void _logoutUser() async
   {
  try {
  await  widget.auth.signOut();
  widget.onSignedOut();
  }
  catch(e){
    print(e.toString());
  }
   }
   @override
   Widget build(BuildContext context) {
    return new Scaffold(
      appBar:new AppBar(
        title: new Text("HomePage"),
      ),
      body: new Container(
      child: postsList.length == 0? new Text("No Blog Post available"): new : Listview.builder
          (
          itemCount: postsList.length,
        itemBuilder: (_, index)
          {
            return PostUI(postList[index].image, postList[index].description, postList[imdex].date, postList[index].time);


          }
      ),
      ),

      bottomNavigationBar: new BottomAppBar(
        color: Colors.green,

        child: new Container(
          margin: const EdgeInsets.only(left: 50.0, right: 60.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              new IconButton(icon: new Icon(Icons.arrow_downward),
              iconSize: 50,
              color: Colors.purple,

                onPressed: _logoutUser,
              ),

              new IconButton(icon: new Icon(Icons.add_a_photo),
                  iconSize: 50,
                  color: Colors.blue,
                onPressed: (){
                Navigator.push
                  (context,
                  MaterialPageRoute(builder: (context){
                    return new UploadPhotoPage();
                  })
                ),
                },

              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget PostUI(String image,String description, String date, String time, )
  {
    returnnew Card
    (
    elevation: 10.0,
        margin: EdgeInsets.all(15.0),

    child: new Container
    (
     padding: new EdgeInsets.all(14.0),
  child: new Column
  (
  crossAxisAlignment: CrossAxisAlignment.start,

  children: <Widget>
    [
      new Row
  (
  mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: <Widget>[
      new Text(
  date, style: Theme.of(context).textTheme.subtitle,
    textAlign: TextAlign.center,
  )

         new Text(
    time,
    style: Theme.of(context).textTheme.subtitle,
  textAlign: TextAlign.center,
    ),
    ],
  )


    SizedBox(height: 10.0,),

  new Image.network(image, fit:BoxFit.cover),

    SizedBox(height: 10.0,),
  new Text(
  description
  style: Theme.of(context).textTheme.subhead,
  textAlign: TextAlign.center,
  ),

    ]
    ),

    );
  }
 }









