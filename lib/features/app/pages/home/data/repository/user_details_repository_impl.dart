import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/model/user_model.dart';
import 'package:packinh/features/app/pages/home/data/datasource/user_details_remote_data_source.dart';
import 'package:packinh/features/app/pages/home/domain/repository/user_details_repository.dart';

class UserDetailsRepositoryImpl extends UserDetailsRepository{
  
  final UserDetailsRemoteDataSource remoteDataSource;
  UserDetailsRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, UserModel>> getUser(String uid) async{
    try{
      final user= await remoteDataSource.getUser(uid);
      return Right(user);
    } on ServerException catch (e){
      return Left(ServerFailure(e.message));
    }
  }
  
}