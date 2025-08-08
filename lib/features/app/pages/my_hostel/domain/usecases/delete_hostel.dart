import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/usecases/usecase.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/hostel_repository.dart';

class DeleteHostel implements UseCase<void, DeleteHostelParams>{

  final HostelRepository repository;

  const DeleteHostel(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteHostelParams params) async{
    return await repository.deleteHostel(params.hostelId);
  }
}

class DeleteHostelParams extends Equatable{

  final String hostelId;
  const DeleteHostelParams({required this.hostelId});

  @override
  List<Object?> get props => [hostelId];

}