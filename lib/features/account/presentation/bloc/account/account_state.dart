import 'package:equatable/equatable.dart';
import 'package:movie_app/features/account/domain/entities/account.dart';

abstract class RequestTokenState extends Equatable{
  @override
  List<Object?> get props => [];
}

class RequestTokenInitial extends RequestTokenState {}
class RequestTokenLoading extends RequestTokenState {}
class RequestTokenLoaded extends RequestTokenState {
  final String token;
  RequestTokenLoaded(this.token);

  @override
  List<Object?> get props => [token];
}
class RequestTokenError extends RequestTokenState {
  final dynamic message;
  RequestTokenError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class CreateSessionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateSessionInitial extends CreateSessionState {}
class CreateSessionLoading extends CreateSessionState {}
class CreateSessionLoaded extends CreateSessionState {}
class CreateSessionError extends CreateSessionState {
  final dynamic message;
  CreateSessionError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class GetAccountState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetAccountInitial extends GetAccountState {}
class GetAccountLoading extends GetAccountState {}
class GetAccountLoaded extends GetAccountState {
  Account account;
  GetAccountLoaded(this.account);

  @override
  List<Object?> get props => [account];
}
class GetAccountError extends GetAccountInitial {
  final dynamic message;
  GetAccountError(this.message);

  @override
  List<Object?> get props => [message];
}
