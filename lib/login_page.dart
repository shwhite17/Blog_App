import 'package:flutter/material.dart';
import 'package:flutter_blog_app/DialogBox.dart';
import 'Authentication.dart';
import 'package:flutter_blog_app/DialogBox.dart';

// ignore: camel_case_types
class login_page extends StatefulWidget

{
  login_page(
  {
    this.auth,
    this.onSignedIn
}
      );



  final AuthImplementation auth;
  final VoidCallback onSignedIn;



  State<StatefulWidget> createState()
  {
    return _login_page();
  }


}

enum FormType
{
  login,
  register
}

// ignore: camel_case_types
class _login_page extends State<login_page>
{
  DialogBox dialogBox = new DialogBox();

 final formKey = new GlobalKey<FormState>();
 FormType _formType= FormType.login;
 String _email = "";
 String _password = "";

  bool validateAndSave(){
    final form= formKey.currentState;
    if(form.validate())
      {
        form.save();
        return true;
      }
    else
      {
        return false;
      }
  }
  void validateAndSubmit() async
  {
    if(validateAndSave())
      {
        try{
          if(_formType== FormType.login)
            {
              String userId = await widget.auth.SignIn(_email, _password);
             // dialogBox.information(context, "Congratulations", "Your are logged in successfully");
                print("login userId=" + userId) ;
            }
          else
            {
              String userId= await widget.auth.SignUp(_email, _password);
             // dialogBox.information(context, "Congratulations", "Your account has been created successfully");

              print("Register  userId = " + userId );

            }
          widget.onSignedIn();
        }
        catch(e){

          dialogBox.information(context,"Error", e.toString());
          print("Error =" +e.toString());
        }
      }
  }
//methods
  void moveToRegister()
  {
    formKey.currentState.reset();

    setState(() {
      _formType= FormType.register;

    });
  }

  void moveToLogin()
  {
 formKey.currentState.reset();

 setState(() {
   _formType= FormType.login;

 });
  }


  //Design
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Axios Blog App"),
        ),

      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(

          key: formKey,

            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
         children: createInputs() + createButtons(),
        ),
        ),

      ),
      );

  }




  List<Widget> createInputs()
  {
    return
        [
        SizedBox(height: 10.0,),
        logo(),
          SizedBox(height: 20.0,),

          new TextFormField(
            decoration: new InputDecoration(labelText: 'Email',
            hintText: 'Enter your Email'),
            validator: (value)
                {
                  return value.isEmpty ? 'Email is required.': null;
                },
              onSaved: (value){
              return _email = value;
              },

          ),
          SizedBox(height: 10.0,),
          new TextFormField(
            decoration: new InputDecoration(labelText: 'Password',
            hintText: 'Enter the Password',
            ),
            obscureText: true,
            validator: (value)
            {
              return value.isEmpty ? 'Password is required.': null;
            },
            onSaved: (value){
              return _password = value;
            },

          ),
          SizedBox(height: 20.0,),
        ];

  }
   Widget logo()
   {
     return new Hero(
       tag: 'hero',
         child: new CircleAvatar
             (
             backgroundColor: Colors.green,
              radius: 110.0,
              child: Image.asset('images/blogo.jpg'),
             ),
         );
   }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return
        [
          new RaisedButton
            (
            child: new Text("Login",
                style: new TextStyle(fontSize: 25.0, color: Colors.black,)
            ),

            textColor: Colors.white,
            color: Colors.green,
            onPressed: validateAndSave,
          ),
          new RaisedButton(
            child: new Text("Signup",
                style: new TextStyle(fontSize: 25.0, color: Colors.black,)),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: moveToRegister,
          ),

        ];
    }

    else
      {

        return
          [
            new RaisedButton
              (
              child: new Text("Create Account",
                  style: new TextStyle(fontSize: 25.0, color: Colors.black,)
              ),

              textColor: Colors.white,
              color: Colors.green,
              onPressed: validateAndSave,
            ),
            new RaisedButton(
              child: new Text("Already have an account, Just Login",
                  style: new TextStyle(fontSize: 25.0, color: Colors.black,)),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: moveToLogin,
            ),

          ];

      }




}
}