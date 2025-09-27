import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../../../core/model/user_model.dart';
import '../repository/user_profile_repository.dart';

class UpdateUserUseCase implements UseCase<void, UserModel> {
  final UserProfileRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UserModel user) async {
    return await repository.updateUser(user);
  }
}