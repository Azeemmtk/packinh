import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/usecases/usecase.dart';
import 'package:packinh/features/auth/domain/repository/auth_repository.dart';

class SendOtp implements UseCase<String, String>{
  final AuthRepository repository;
  SendOtp(this.repository);
  @override
  Future<Either<Failure, String>> call(String phoneNumber) async{
    return await repository.sendOtp(phoneNumber);
  }

}