import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_client.dart';
import 'package:shoptoken/repositories/api_repository.dart';
import 'package:shoptoken/views/booktickets/bloc/bookticket.dart';

import 'package:shoptoken/views/category/bloc/category_bloc.dart';

import 'package:shoptoken/views/login/bloc/login.dart';
import 'package:shoptoken/views/stores/bloc/neareststore_bloc.dart';

import 'views/login/ui/login_page.dart';

void main() {
  final APIRepository _apirepository = APIRepository(ShopApiClient());
  runApp(MyApp(apirepository: _apirepository));
}

class MyApp extends StatelessWidget {
  APIRepository apirepository;

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
          home: LoginPage(title: 'Customer Login'),
          // routes: <String, WidgetBuilder>{
          //   //app routes
          //   '/loginscreen': (BuildContext context) => new LoginPage(),
          //   '/categoryscreen': (BuildContext context) => new CategoryScreen(),
          //   '/storesscreen': (BuildContext context) => new StoresScreen(),
          //   '/bookconfirmscreen': (BuildContext context) =>
          //       new BookConfirmScreen(),
          // }
        ));
  }
}
