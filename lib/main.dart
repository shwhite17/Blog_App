import 'package:flutter/material.dart';
import 'package:flutter_blog_app/login_page.dart';
import 'package:flutter_blog_app/mapping.dart';
import 'homepage.dart';
import 'mapping.dart';
import 'Authentication.dart';

void main (){
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp(
      title: "Blog App",

      theme: new ThemeData(
        primarySwatch: Colors.green,

      ),
      home: mapping(auth: Auth(),),
    );
  }
}