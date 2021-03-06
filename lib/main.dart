import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_client.dart';
import 'package:shoptoken/repositories/api_repository.dart';
import 'package:shoptoken/routes/pageroutes.dart';
import 'package:shoptoken/service/firebasenotifications.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket.dart';
import 'package:shoptoken/views/booktickets/ui/book_confirm.dart';

import 'package:shoptoken/views/category/bloc/category_bloc.dart';
import 'package:shoptoken/views/home/ui/home_screen.dart';

import 'package:shoptoken/views/login/bloc/login.dart';
import 'package:shoptoken/views/stores/bloc/neareststore_bloc.dart';
import 'package:shoptoken/views/stores/ui/storelist.dart';
import 'package:shoptoken/views/userlocation/ui/user_location.dart';

import 'views/booktickets/ui/user_booking.dart';
import 'views/login/ui/login_page.dart';
import 'views/stores/ui/users_fav_store.dart';
import 'views/userprofile/ui/user_profile.dart';

void main() {
  final APIRepository _apirepository = APIRepository(ShopApiClient());
  runApp(MyApp(apirepository: _apirepository));
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
                    return StoresScreen();
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
