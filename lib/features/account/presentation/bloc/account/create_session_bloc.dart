import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/account/domain/usecases/create_session_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_event.dart';
import 'package:movie_app/features/account/presentation/bloc/account/account_state.dart';

class CreateSessionBloc extends Bloc<CreateSessionEvent, CreateSessionState> {
  final CreateSessionUseCase useCase;

  CreateSessionBloc(this.useCase): super(CreateSessionInitial()) {
    on<CreateSessionEvent>(_onCreateSession);
  }

  _onCreateSession(CreateSessionEvent event, Emitter<CreateSessionState> emitter) async {
    emitter(CreateSessionLoading());
    final result = await useCase.call(event.request_token);

      result.fold(
          (failure) => emitter(CreateSessionError(failure.message)),
          (isSuccess) => emitter(CreateSessionLoaded()));
  }
}