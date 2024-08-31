import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/usecases/create_session_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/get_account_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/request_token_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_event.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_state.dart';

class GetAccountBloc extends Bloc<GetAccountEvent, GetAccountState> {
  final GetAccountUseCase getAccountUseCase;

  GetAccountBloc(this.getAccountUseCase): super(GetAccountInitial()) {
    on<GetAccountEvent>(_onGetAccount);
  }

  Future<void> _onGetAccount(GetAccountEvent event, Emitter<GetAccountState> emitter) async {
    emitter(GetAccountLoading());

    final result = await getAccountUseCase.call(NoParam());

    result.fold(
            (failure) => emitter(GetAccountError(failure.message)),
            (account) => emitter(GetAccountLoaded(account))
    );
  }
}