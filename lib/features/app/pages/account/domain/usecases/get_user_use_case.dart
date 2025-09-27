import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../../../core/model/user_model.dart';
import '../repository/user_profile_repository.dart';

class GetUserUseCase implements UseCase<UserModel, String> {
  final UserProfileRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(String uid) async {
    return await repository.getUser(uid);
  }
}