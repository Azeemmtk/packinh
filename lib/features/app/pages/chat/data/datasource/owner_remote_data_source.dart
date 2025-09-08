import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/error/exceptions.dart';


abstract class OwnerRemoteDataSource {
  Future<Map<String, String>> getOwnerDetails(String ownerId);
}

class OwnerRemoteDataSourceImpl implements OwnerRemoteDataSource {
  final FirebaseFirestore firestore;

  OwnerRemoteDataSourceImpl(this.firestore);

  @override
  Future<Map<String, String>> getOwnerDetails(String ownerId) async {
    try {
      final ownerDoc = await firestore.collection('users').doc(ownerId).get();
      if (!ownerDoc.exists) {
        throw ServerException('user not found');
      }
      // Use exact field names from Firestore and provide fallbacks
      final data = ownerDoc.data() as Map<String, dynamic>;
      return {
        'displayName': data['displayName']?.toString() ?? 'Unknown',
        'photoURL': data['photoURL']?.toString() ?? '',
      };
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}