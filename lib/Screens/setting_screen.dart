import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // dark mode
            Text('Dark Mode', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),

            // switch toggle

            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toogleTheme())
          ],
        ),
      ),
    );
  }
}
