import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_repository.dart';

import 'neareststore_event.dart';
import 'neareststore_state.dart';

class NearestStoreBloc extends Bloc<NearestStoreEvent, NearestStoreState> {
  final APIRepository apireporsitory;

  NearestStoreBloc({@required this.apireporsitory})
      : super(NearestStoreInitial());

  // @override
  // NearestStoreState get initialState => NearestStoreInitial();

  @override
  Stream<NearestStoreState> mapEventToState(NearestStoreEvent event) async* {
    if (event is FetchNearestStoreEventList) {
      yield NearestStoreInProgress();
      try {
        final result = await apireporsitory.categoryList();
        print("response --- $result");
        yield NearestStoreSuccess(result);
      } catch (error) {
        yield NearestStoreFailure(error: error.toString());
      }
    }
  }
}
