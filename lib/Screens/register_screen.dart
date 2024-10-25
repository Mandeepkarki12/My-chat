import 'package:flutter/material.dart';
import 'package:my_chat/Widgets/my_button.dart';
import 'package:my_chat/Widgets/my_textfield.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
 final void Function()? onTap;

  RegisterScreen({super.key, required this.onTap});
  register() {}
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
              Icons.app_registration,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            // welcome message
            Text(
              "Let's create an account for you !!",
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
              height: 10,
            ),
            //confirm  pw text field
            MyTextfield(
              hintText: 'Confirm-Password',
              obscureText: true,
              controller: _confirmPassword,
            ),
            const SizedBox(
              height: 25,
            ),
            // login button
            MyButton(
              text: "Register",
              onTap: register,
            ),
            const SizedBox(
              height: 25,
            ),
            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account ?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    ' Login Now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
