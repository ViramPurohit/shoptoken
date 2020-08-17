import 'package:flutter/material.dart';
import 'package:shoptoken/routes/pageroutes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              icon: Icons.contacts,
              colors: Colors.blueAccent,
              text: 'Contacts',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, PageRoutes.home),
            ),
            _createDrawerItem(
              icon: Icons.event,
              colors: Colors.blueAccent,
              text: 'Events',
            ),
            _createDrawerItem(
              icon: Icons.note,
              colors: Colors.blueAccent,
              text: 'Notes',
            ),
            Divider(),
            _createDrawerItem(
                icon: Icons.collections_bookmark,
                colors: Colors.blueAccent,
                text: 'Steps'),
            _createDrawerItem(
                icon: Icons.face, colors: Colors.blueAccent, text: 'Authors'),
            _createDrawerItem(
                icon: Icons.account_box,
                colors: Colors.blueAccent,
                text: 'Flutter Documentation'),
            _createDrawerItem(
                icon: Icons.stars,
                colors: Colors.blueAccent,
                text: 'Useful Links'),
            Divider(),
            _createDrawerItem(
                icon: Icons.bug_report,
                colors: Colors.blueAccent,
                text: 'Report an issue'),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: ListTile(
                title: Text('1.0.1'),
                onTap: () {},
              ),
            ),
          ]),
        ));
  }

  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/icons/drawer_header.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Viram Purohit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData icon, Color colors, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: colors),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
