import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/services/current_user.dart';

import '../../domain/entity/report_entity.dart';

abstract class ReportDataSource {
  Future<List<ReportEntity>> fetchReportsBySenderId();
}

class ReportDataSourceImpl implements ReportDataSource {
  final FirebaseFirestore firestore;

  ReportDataSourceImpl({required this.firestore});

  @override
  Future<List<ReportEntity>> fetchReportsBySenderId() async {

    final currentUser= CurrentUser().uId;
    final snapshot = await firestore.collection('reports')
        .where('ownerId', isEqualTo: currentUser)
        .get();
    return snapshot.docs
        .map((doc) => ReportEntity.fromMap(doc.data(), doc.id))
        .toList();
  }
}