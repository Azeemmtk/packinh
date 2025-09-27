import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/model/user_model.dart';
import 'package:packinh/core/usecases/usecase.dart';
import 'package:packinh/features/app/pages/home/domain/repository/user_details_repository.dart';

class GetUserDetailsUseCase extends UseCase<UserModel, String>{
  final UserDetailsRepository repository;

  GetUserDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(String params) async{
    return await repository.getUser(params);
  }
}