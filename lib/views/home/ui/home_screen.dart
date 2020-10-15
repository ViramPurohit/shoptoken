import 'package:Retailer/utils/apppreferences.dart';
import 'package:Retailer/views/customerlist/ui/customer.dart';
import 'package:flutter/material.dart';
import 'package:Retailer/routes/pageroutes.dart';
import 'package:Retailer/views/booktickets/ui/book_confirm.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onHeaderClick;

  const HomeScreen({Key key, this.onHeaderClick}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

String shopName = "Shop name";
int retailerId = 14;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    retailerId = await Apppreferences().getUserId();
    shopName = await Apppreferences().getShopName();

    print('shopName $shopName');
    print('retailerId $retailerId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer list'),
      ),
      body: CustomerScreen(),
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
        _createHeader(context),
        // _createDrawerItem(
        //     select: false,
        //     icon: Icons.shopping_basket,
        //     colors: Colors.blueAccent,
        //     text: 'Customer list',
        //     onTap: () {
        //       Navigator.pop(context);
        //       Navigator.pushNamed(context, PageRoutes.customerlist);
        //     }),
        _createDrawerItem(
            select: false,
            icon: Icons.bookmark,
            colors: Colors.blueAccent,
            text: 'Profile',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.userProfile);
            }),
        _createDrawerItem(
            select: false,
            icon: Icons.settings,
            colors: Colors.blueAccent,
            text: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.setting);
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

  Widget _createHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/icons/drawer_header.png'))),
      accountName: Text(shopName),
      accountEmail: Text(retailerId.toString()),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          shopName[0],
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
