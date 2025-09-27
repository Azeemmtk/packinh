import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/model/user_model.dart';

abstract class UserDetailsRemoteDataSource {
  Future<UserModel> getUser(String uid);
}

class UserDetailsRemoteDataSourceImpl implements UserDetailsRemoteDataSource {
  final FirebaseFirestore firestore;

  UserDetailsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<UserModel> getUser(String uid) async {
    try {
      final doc = await firestore.collection('hostel_owners').doc(uid).get();
      print(doc.data());
      if (!doc.exists) {
        throw ServerException('User not found');
      }
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}