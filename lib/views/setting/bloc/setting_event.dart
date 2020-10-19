import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class ChangeSlotValueEvent extends SettingEvent {
  final Map<String, dynamic> requestMap;

  ChangeSlotValueEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SubmitCategoryEvent { Request Data: $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class EnableHolidayEvent extends SettingEvent {
  final Map<String, dynamic> requestMap;

  EnableHolidayEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SubmitCategoryEvent { Request Data: $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
