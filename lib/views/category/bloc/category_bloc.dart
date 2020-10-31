import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptoken/repositories/api_repository.dart';

import 'package:shoptoken/views/category/bloc/category_event.dart';
import 'package:shoptoken/views/category/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final APIRepository apireporsitory;

  CategoryBloc({@required this.apireporsitory}) : super(CategoryInitial());

  // @override
  // CategoryState get initialState => CategoryInitial();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    print("CategoryBloc event --- $event");
    if (event is FetchCategoryList) {
      yield CategoryInProgress();
      try {
        final result = await apireporsitory.categoryList();
        yield CategorySuccess(result);
      } catch (error) {
        yield CategoryFailure(error: error.toString());
      }
    }
    if (event is CategorySelectEvent) {
      print("CategoryBloc event --- ${event.categoryIds}");
      yield CategorySelectSuccess(event.categoryIds);
    }
  }
}
