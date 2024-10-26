import 'package:flutter/material.dart';
import 'package:my_chat/Services/Auth/auth_service.dart';
import 'package:my_chat/Screens/setting_screen.dart';

class MyDrawer extends StatelessWidget {
  logout() {
    final _auth = AuthService();
    _auth.signOut();
  }
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: Icon(Icons.message_sharp,
                    color: Theme.of(context).colorScheme.primary, size: 40),
              ),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title:const  Text('H O M E'),
                  leading:const  Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // setting list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title:const  Text('S E T T I N G S'),
                  leading:const  Icon(Icons.settings),
                  onTap: () {
                     Navigator.pop(context);
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
                  },
                ),
              ),
            ],
          ),
          // logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(
              title:const  Text('L O G O U T'),
              leading:const  Icon(Icons.logout),
              onTap: () {
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
