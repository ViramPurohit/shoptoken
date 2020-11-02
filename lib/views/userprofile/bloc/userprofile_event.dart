import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserprofileEvent extends Equatable {
  const UserprofileEvent();
}

class UserDetailsEvent extends UserprofileEvent {
  final Map<String, dynamic> requestMap;

  UserDetailsEvent({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "SubmitCategoryEvent { Request Data: $requestMap}";

  @override
  List<Object> get props => [requestMap];
}
