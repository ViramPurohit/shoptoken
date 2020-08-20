import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_client.dart';
import 'package:shoptoken/repositories/api_repository.dart';
import 'package:shoptoken/routes/pageroutes.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket.dart';
import 'package:shoptoken/views/booktickets/ui/book_confirm.dart';

import 'package:shoptoken/views/category/bloc/category_bloc.dart';
import 'package:shoptoken/views/home/ui/home_screen.dart';

import 'package:shoptoken/views/login/bloc/login.dart';
import 'package:shoptoken/views/stores/bloc/neareststore_bloc.dart';
import 'package:shoptoken/views/userlocation/ui/user_location.dart';

import 'views/booktickets/ui/user_booking.dart';
import 'views/login/ui/login_page.dart';
import 'views/stores/ui/users_fav_store.dart';
import 'views/userprofile/ui/user_profile.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['status'];
  return item;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPage(itemId),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage(this.itemId);
  final String itemId;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Item _item;
  StreamSubscription<Item> _subscription;

  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((Item item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  String _homeScreenText = "Waiting for token...";
  bool _topicButtonsDisabled = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _topicController =
      TextEditingController(text: 'topic');

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      _firebaseMessaging.subscribeToTopic("matchscore");
      print(_homeScreenText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Push Messaging Demo'),
        ),
        // For testing -- simulate a message being received
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showItemDialog(<String, dynamic>{
            "data": <String, String>{
              "id": "2",
              "status": "out of stock",
            },
          }),
          tooltip: 'Simulate Message',
          child: const Icon(Icons.message),
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(_homeScreenText),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _topicController,
                      onChanged: (String v) {
                        setState(() {
                          _topicButtonsDisabled = v.isEmpty;
                        });
                      }),
                ),
                FlatButton(
                  child: const Text("subscribe"),
                  onPressed: _topicButtonsDisabled
                      ? null
                      : () {
                          _firebaseMessaging
                              .subscribeToTopic(_topicController.text);
                          _clearTopicText();
                        },
                ),
                FlatButton(
                  child: const Text("unsubscribe"),
                  onPressed: _topicButtonsDisabled
                      ? null
                      : () {
                          _firebaseMessaging
                              .unsubscribeFromTopic(_topicController.text);
                          _clearTopicText();
                        },
                ),
              ])
            ],
          ),
        ));
  }

  void _clearTopicText() {
    setState(() {
      _topicController.text = "";
      _topicButtonsDisabled = true;
    });
  }
}

void main() {
  // final APIRepository _apirepository = APIRepository(ShopApiClient());
  // runApp(MyApp(apirepository: _apirepository));
  runApp(
    MaterialApp(
      home: PushMessagingExample(),
    ),
  );
}

// https://api.flutter.dev/flutter/widgets/Navigator-class.html
class MyApp extends StatelessWidget {
  final APIRepository apirepository;

  MyApp({Key key, @required this.apirepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(apirepository: apirepository)),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(apireporsitory: apirepository),
          ),
          BlocProvider<NearestStoreBloc>(
            create: (context) =>
                NearestStoreBloc(apireporsitory: apirepository),
          ),
          BlocProvider<BookTicketBloc>(
            create: (context) => BookTicketBloc(apireporsitory: apirepository),
          )
        ],
        child: MaterialApp(
          color: Colors.white,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<bool>(
              future: Apppreferences().isUserLogin(),
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  print('======= snapshot.data======== ${snapshot.data}');
                  if (snapshot.data == true) {
                    // return HomeScreen();
                    return LoginPage(title: 'Customer Login');
                  } else {
                    return LoginPage(title: 'Customer Login');
                  }
                } else {
                  return LoginPage(title: 'Customer Login');
                }
                // return PlaceDetail();
              }),
          routes: {
            PageRoutes.mybookings: (context) => UserBooking(),
            PageRoutes.userfavstores: (context) => UserFavStores(),
            PageRoutes.userProfile: (context) => UserProfile(),
          },
        ));
  }
}
