import 'package:flutter/material.dart';
import 'package:shoptoken/routes/pageroutes.dart';
import 'package:shoptoken/views/booktickets/ui/book_confirm.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onHeaderClick;

  const HomeScreen({Key key, this.onHeaderClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Booked'),
      ),
      // body: BookConfirmScreen(),
      drawer: Drawer(child: HomeMenuList(
        onHeaderClick: () {
          Navigator.of(context).pop();
          showLogoutDialog();
        },
      )),
    );
  }

  void showLogoutDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Logout"),
              content: new Text("Do you want to Logout?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

class HomeMenuList extends StatelessWidget {
  final VoidCallback onHeaderClick;

  HomeMenuList({this.onHeaderClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: <Widget>[
        _createHeader(),
        _createDrawerItem(
            select: false,
            icon: Icons.shopping_basket,
            colors: Colors.blueAccent,
            text: 'Bookings',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.mybookings);
            }),
        _createDrawerItem(
            select: false,
            icon: Icons.bookmark,
            colors: Colors.blueAccent,
            text: 'Favourite stores',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.userfavstores);
            }),
        _createDrawerItem(
            select: false,
            icon: Icons.settings,
            colors: Colors.blueAccent,
            text: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.userProfile);
            }),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: ListTile(
            title: Text('1.0.1'),
            onTap: () {},
          ),
        ),
      ]),
    );
  }

  Widget _createHeader() {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/icons/drawer_header.png'))),
      accountName: Text("Viram P"),
      accountEmail: Text("virampurohit@clarion.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          "V",
          style: TextStyle(
              color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.w500),
        ),
      ),
      onDetailsPressed: onHeaderClick,
    );
  }

  Widget _createDrawerItem(
      {bool select,
      IconData icon,
      Color colors,
      String text,
      GestureTapCallback onTap}) {
    return ListTile(
      selected: select,
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
