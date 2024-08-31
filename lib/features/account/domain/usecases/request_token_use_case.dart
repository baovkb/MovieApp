import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';

class RequestTokenUseCase implements UseCase<String, NoParam> {
  AccountRepository repository;

  RequestTokenUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParam params) {
    return repository.requestToken();
  }
}