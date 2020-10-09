import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final Map<String, dynamic> requestMap;

  LoginButtonPressed({@required this.requestMap});

  // get name => null;

  @override
  String toString() => "On Login click { User name : $requestMap}";

  @override
  List<Object> get props => [requestMap];
}

class UploadShopCertificate extends LoginEvent {
  final int retailerId;
  final String imagePath;

  UploadShopCertificate({@required this.retailerId, @required this.imagePath});

  // get name => null;

  @override
  String toString() => "Retailer_id $retailerId}";

  @override
  List<Object> get props => [retailerId];
}
