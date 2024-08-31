import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/usecases/request_token_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_event.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_state.dart';

class RequestTokenBloc extends Bloc<RequestTokenEvent, RequestTokenState> {
  final RequestTokenUseCase useCase;

  RequestTokenBloc(this.useCase) : super(RequestTokenInitial()) {
    on<RequestTokenEvent>(_onRequestToken);
  }

  Future<void> _onRequestToken(RequestTokenEvent event, Emitter<RequestTokenState> emitter) async {
    emitter(RequestTokenLoading());

    final result = await useCase.call(NoParam());
    result.fold(
            (failure) => emitter(RequestTokenError(failure.message)),
            (token) => emitter(RequestTokenLoaded(token)));
  }

}