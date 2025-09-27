import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/model/user_model.dart';

abstract class UserDetailsRepository{
  Future<Either<Failure, UserModel>> getUser(String uid);
}