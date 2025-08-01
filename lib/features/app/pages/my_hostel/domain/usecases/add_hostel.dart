import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/usecases/usecase.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/hostel_repository.dart';

class AddHostel implements UseCase<void, HostelEntity>{

  final HostelRepository repository;
  AddHostel(this.repository);

  @override
  Future<Either<Failure, void>> call(HostelEntity params) async{
    return await repository.addHostel(params);
  }

}