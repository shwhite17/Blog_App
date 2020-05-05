import 'package:flutter/material.dart';
import 'login_page.dart';
import 'homepage.dart';
import 'Authentication.dart';

class mapping extends StatefulWidget{
  final AuthImplementation auth;

  mapping(
  {
  this.auth
}
      );
 State<StatefulWidget> createState()
 {
   return _mappingState();

 }


}

enum AuthStatus
{
  notSignedIN
  signedIn,
}

class _mappingState extends State<mapping>
{
  AuthStatus _authStatus= AuthStatus.notSignedIN;

  @override
  void iniState()
  {
    super.initState();
     widget.auth.getCurrentUser().then(firebaseUserId)
    {
      setState((){
      authStatus  = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn
      });
    };

}
  void _signedIn()
  {
    setState(() {
      _authStatus=AuthStatus.signedIn;
    });
  }

  void _signed()
  {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }
  void _signOut()
  {
    setState(()
    {
      _authStatus=AuthStatus.notSignedIN
    });
  }

  @override
  Widget build(BuildContext context)
  {
    switch(authStatus)
    {
      case AuthStatus.notSignedIN;
      return new login_page(
        auth: widget.auth,
        onSignedIn: _signedIn,
      );
      case AuthStatus.notSignedIN
        return new login_page(
          auth: widget.auth,
          onSignedOut: _signedIn,
        );


    }


    return null;
  }
}