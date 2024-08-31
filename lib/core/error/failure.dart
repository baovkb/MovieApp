import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception{
  final dynamic message;

  const Failure([this.message]);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

class ClientError extends Failure {
  const ClientError([super.message]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);
}

class UnknownError extends Failure {
  const UnknownError([super.message]);
}