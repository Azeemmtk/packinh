import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/model/hostel_model.dart';

abstract class HostelRemoteDataSource {
  Future<Either<Failure, void>> addHostel(HostelEntity hostel);
  Future<Either<Failure, List<HostelEntity>>> getHostelsByOwnerId(String ownerId);
  Future<void> deleteHostel(String id);
  Future<void> updateHostel(HostelEntity hostel);
}

class HostelRemoteDataSourceImpl implements HostelRemoteDataSource {
  final FirebaseFirestore firestore;

  HostelRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, void>> addHostel(HostelEntity hostel) async {
    try {
      final hostelModel = HostelModel.fromEntity(hostel);
      await firestore.collection('hostels').doc(hostel.id).set(hostelModel.toJson());
      debugPrint('Hostel added successfully: ${hostel.id}');
      return const Right(null);
    } catch (e) {
      debugPrint('Error adding hostel: $e');
      return Left(ServerFailure('Failed to add hostel: $e'));
    }
  }

  @override
  Future<Either<Failure, List<HostelEntity>>> getHostelsByOwnerId(String ownerId) async {
    try {
      if (ownerId.isEmpty) {
        debugPrint('Error: ownerId is empty');
        return Left(ServerFailure('Owner ID is empty'));
      }
      debugPrint('Fetching hostels for ownerId: $ownerId');
      final querySnapshot = await firestore
          .collection('hostels')
          .where('ownerId', isEqualTo: ownerId)
          .get();
      final hostels = querySnapshot.docs
          .map((doc) => HostelModel.fromJson(doc.data()).toEntity())
          .toList();
      debugPrint('Fetched ${hostels.length} hostels for ownerId: $ownerId');
      return Right(hostels);
    } catch (e) {
      debugPrint('Error fetching hostels: $e');
      return Left(ServerFailure('Failed to fetch hostels: $e'));
    }
  }

  @override
  Future<void> deleteHostel(String id) async{
    await firestore.collection('hostels').doc(id).delete();
  }

  @override
  Future<void> updateHostel(HostelEntity hostel) async {
    try {
      final hostelModel = HostelModel.fromEntity(hostel);
      await firestore.collection('hostels').doc(hostel.id).update(hostelModel.toJson());
      debugPrint('Hostel updated successfully: ${hostel.id}');
    } catch (e) {
      debugPrint('Error updating hostel: $e');
      throw ServerException('Failed to update hostel: $e');
    }
  }
}