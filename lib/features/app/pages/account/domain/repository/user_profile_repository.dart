import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/model/user_model.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserModel>> getUser(String uid);
  Future<Either<Failure, void>> updateUser(UserModel user);
}