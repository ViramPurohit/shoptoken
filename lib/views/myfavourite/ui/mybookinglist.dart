import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/models/getfavoriteresponse.dart';
import 'package:shoptoken/utils/apppreferences.dart';
import 'package:shoptoken/utils/dialog.dart';
import 'package:shoptoken/utils/util_page.dart';
import 'package:shoptoken/views/myfavourite/bloc/favourite.dart';

import 'bookingList_result.dart';

class MyFavouriteList extends StatefulWidget {
  MyFavouriteList({Key key}) : super(key: key);

  @override
  _MyFavouriteListState createState() => new _MyFavouriteListState();
}

class _MyFavouriteListState extends State<MyFavouriteList> {
  List<FavoriteData> favListList;
  FavouriteBloc _favouriteBloc;

  @override
  void initState() {
    super.initState();
    _favouriteBloc = BlocProvider.of<FavouriteBloc>(context);
    favListList = new List<FavoriteData>();

    submitCategory();
  }

  Future<void> submitCategory() async {
    var requestMap = new Map<String, dynamic>();
    requestMap['customer_id'] = await Apppreferences().getUserId();

    _favouriteBloc.add(MyFavouriteListEvent(requestMap: requestMap));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (BuildContext context, FavouriteState state) {
        if (state is FavouriteSuccess) {
          Dialogs().dismissLoaderDialog(context);
          print(state.result);
          if (state.result.getfavoriteresult.isError == 0) {
            favListList = state.result.getfavoriteresult.data;
          } else {
            Util().showToast(context, state.result.getfavoriteresult.message);
          }
        }
        if (state is FavouriteInProgress) {
          Dialogs().showLoaderDialog(context);
        }

        if (state is FavouriteFailure) {
          Dialogs().dismissLoaderDialog(context);
          Util().showErrorToast(context, state.error);
        }
      },
      child: BlocBuilder<FavouriteBloc, FavouriteState>(
        // bloc: BlocProvider.of<BookTicketBloc>(context),
        builder: (BuildContext context, FavouriteState state) {
          return Container(
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: favListList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child:
                                          Text('Collecting Favourite stores'))
                                  : MyFavouriteListResult(
                                      favList: favListList,
                                    )),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
