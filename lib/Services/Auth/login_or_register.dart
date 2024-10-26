import 'package:flutter/material.dart';
import 'package:my_chat/Screens/login_screen.dart';
import 'package:my_chat/Screens/register_screen.dart';
class LoginOrRegister  extends StatefulWidget{
  const LoginOrRegister({super.key});
  @override
  State<StatefulWidget> createState() {
   return _LoginOrRegisterState();
  }
}
class _LoginOrRegisterState extends State<LoginOrRegister>
{
  // initially show login page 
  bool showLoginPage = true ;
  // toogle between two pages 
  void togglePages()
  {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap:  togglePages,
      );
    }
    else{
      return RegisterScreen(
        onTap:  togglePages,
      );
    }
  }
}