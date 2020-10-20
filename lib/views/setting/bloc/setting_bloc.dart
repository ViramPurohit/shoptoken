import 'package:Retailer/views/setting/bloc/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Retailer/repositories/api_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final APIRepository apireporsitory;

  SettingBloc({@required this.apireporsitory}) : super(SettingInitial());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    print("event --- $event");
    if (event is ChangeSlotValueEvent) {
      yield SettingProgress();
      try {
        final result =
            await apireporsitory.updatetimeslot(requestMap: event.requestMap);
        print("response --- $result");
        yield ChangeSlotValueSuccess(result);
      } catch (error) {
        yield SettingFailure(error: error.toString());
      }
    }
    if (event is EnableHolidayEvent) {
      yield SettingProgress();
      try {
        final result =
            await apireporsitory.enableholiday(requestMap: event.requestMap);
        print("response --- $result");
        yield EnableHolidaySuccess(result);
      } catch (error) {
        yield SettingFailure(error: error.toString());
      }
    }
  }
}
