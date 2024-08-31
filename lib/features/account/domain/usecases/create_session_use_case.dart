import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/account/domain/repositories/account_repository.dart';

class CreateSessionUseCase implements UseCase<bool, String> {
  AccountRepository repository;

  CreateSessionUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String requestToken) async {
    final result = await repository.createSession(requestToken);
    
    if (result.isLeft()) {
      return Left((result as Left).value);
    } else {
      String session = (result as Right).value;
      final saveRes = await repository.saveSession(session);
      return saveRes;
    }
  }
}