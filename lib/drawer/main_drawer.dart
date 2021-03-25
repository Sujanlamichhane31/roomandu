import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/Dell/AndroidStudioProjects/commerce/formvalidate/roomandu/lib/provider/user_repository.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Flexible(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.cyanAccent,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    child: const Text('1234')
//                    CircleAvatar(
//                      backgroundImage:
//                          NetworkImage(googleSignIn.currentUser.photoUrl),
//                    ),
                  ),
                  const Text(
                    '123',
//                    googleSignIn.currentUser.displayName,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '12345',
//                    googleSignIn.currentUser.email,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.explore),
            title: Text(
              'Explore',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.hotel),
            title: Text(
              'hotel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.room_service),
            title: Text(
              'Room and services',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 0.5,
          ),
          ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'About Us',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/aboutus');
              }),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back),
            title: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Provider.of<UserRepository>(context).signOut();
            },
          ),
        ],
      ),
    ));
  }
}


