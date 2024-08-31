import 'package:equatable/equatable.dart';

class RequestTokenEvent {}

class CreateSessionEvent {
  final request_token;

  CreateSessionEvent(this.request_token);
}

class GetAccountEvent {}