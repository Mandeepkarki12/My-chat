import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/Services/Auth/login_or_register.dart';
import 'package:my_chat/Screens/home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AuthGateState();
  }
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          
           builder: (context, snapshot)
           {
            if (snapshot.hasData) {
              return const  HomeScreen();
            }
            else
            {
              return LoginOrRegister();
            }
           }
           
           ),
    );
  }
}
