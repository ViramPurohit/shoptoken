import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/repositories/api_repository.dart';

import 'package:Retailer/views/category/bloc/category_event.dart';
import 'package:Retailer/views/category/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final APIRepository apireporsitory;

  CategoryBloc({@required this.apireporsitory}) : super(CategoryInitial());

  // @override
  // CategoryState get initialState => CategoryInitial();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    print("Event name $event");
    if (event is FetchCategoryList) {
      yield CategoryInProgress();
      try {
        final result = await apireporsitory.categoryList();
        yield CategorySuccess(result);
      } catch (error) {
        yield CategoryFailure(error: error.toString());
      }
    } else if (event is CategoryItemSelect) {
      print("Event name CategoryItemSelect");
      yield CategorySelectSuccess(event.selectedList);
    } else if (event is SubmitCategoryEvent) {
      print("Event name CategorySubmitSuccess");
      yield CategoryInProgress();
      try {
        final result =
            await apireporsitory.submitCategory(requestMap: event.requestMap);
        yield CategorySubmitSuccess(result);
      } catch (error) {
        yield CategoryFailure(error: error.toString());
      }
    }
  }
}
