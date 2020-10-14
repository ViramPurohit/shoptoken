import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
}

class CustomerListEvent extends CustomerEvent {
  final Map<String, dynamic> requestMap;

  CustomerListEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SubmitCategoryEvent { Request Data: $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class EnterCodeButtonEvent extends CustomerEvent {
  final Map<String, dynamic> requestMap;

  EnterCodeButtonEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SubmitCategoryEvent { Request Data: $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
