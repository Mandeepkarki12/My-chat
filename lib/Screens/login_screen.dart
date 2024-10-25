import 'package:flutter/material.dart';
import 'package:my_chat/Widgets/my_button.dart';
import 'package:my_chat/Widgets/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  // email and password controller
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  LoginScreen({super.key});
  login() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message_outlined,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            // welcome message
            Text(
              'Welcome back ,you have been missed!!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            // email text field

            MyTextfield(
              hintText: 'Email',
              obscureText: false,
              controller: _email,
            ),
            const SizedBox(
              height: 10,
            ),
            // pw text field
            MyTextfield(
              hintText: 'Password',
              obscureText: true,
              controller: _password,
            ),
            const SizedBox(
              height: 25,
            ),
            // login button
            MyButton(
              text: "Login",
              onTap: login,
            ),
            const SizedBox(
              height: 25,
            ),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member ?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  ' Register Now',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
