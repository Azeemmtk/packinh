import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/error/exceptions.dart';

import '../../../../../../core/model/occupants_model.dart';

class OccupantsRemoteDataSource {
  final FirebaseFirestore firestore;

  OccupantsRemoteDataSource(this.firestore);

  Future<List<OccupantModel>> getOccupantsByHostelId(String hostelId) async {
    try {
      final query = firestore.collection('occupants').where('hostelId', isEqualTo: hostelId);
      final snapshots = await query.get();
      return snapshots.docs.map((doc) {
        final data = doc.data();
        return OccupantModel.fromJson(data)..id = doc.id;
      }).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<OccupantModel> getOccupantById(String occupantId) async {
    try {
      final doc = await firestore.collection('occupants').doc(occupantId).get();
      if (!doc.exists) {
        throw ServerException('Occupant not found');
      }
      final data = doc.data()!;
      return OccupantModel.fromJson(data)..id = doc.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}