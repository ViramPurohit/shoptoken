import 'package:flutter/material.dart';
import 'package:shoptoken/routes/pageRoutes.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/views/mybookings/ui/user_booking.dart';
import 'package:shoptoken/views/login/ui/login_page.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onHeaderClick;

  const HomeScreen({Key key, this.onHeaderClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

String customername = "Customer Name";
int customerId = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    customerId = await Apppreferences().getUserId();
    customername = await Apppreferences().getFullName();

    print('shopName $customername');
    print('retailerId $customerId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: UserBooking(),
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
                    Apppreferences().clearApppreferences();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
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
            text: 'Profile',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.userProfile);
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
      accountName: Text(customername),
      accountEmail: Text(customerId.toString()),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          customername[0],
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
