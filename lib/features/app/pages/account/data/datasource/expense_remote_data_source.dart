import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:packinh/core/model/hostel_model.dart';

import '../../domain/entity/expense.dart';

abstract class ExpenseRemoteDataSource {
  Future<List<HostelEntity>> fetchHostels();
  Future<List<Expense>> fetchExpenses(List<String> hostelIds);
  Future<void> addExpense(Expense expense);
  Future<void> deleteExpense(String id);
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final FirebaseFirestore firestore;

  ExpenseRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HostelEntity>> fetchHostels() async {
    try {
      final userId = CurrentUser().uId;
      final hostelQuery = await firestore
          .collection('hostels')
          .where('ownerId', isEqualTo: userId)
          .get();

      return hostelQuery.docs.map((doc) => HostelModel.fromJson(doc.data()).toEntity()).toList();
    } catch (e) {
      throw ServerException('Failed to fetch hostels: $e');
    }
  }

  @override
  Future<List<Expense>> fetchExpenses(List<String> hostelIds) async {
    try {
      if (hostelIds.isEmpty) return [];
      final expenseQuery = await firestore
          .collection('expenses')
          .where('hostelId', whereIn: hostelIds)
          .get();

      return expenseQuery.docs.map((doc) {
        final data = doc.data();
        return Expense(
          id: doc.id,
          hostelId: data['hostelId'] as String,
          hostelName: data['hostelName'] as String,
          amount: (data['amount'] as num).toDouble(),
          description: data['description'] as String,
          date: (data['date'] as Timestamp).toDate(),
        );
      }).toList();
    } catch (e) {
      throw ServerException('Failed to fetch expenses: $e');
    }
  }

  @override
  Future<void> addExpense(Expense expense) async {
    try {
      await firestore.collection('expenses').add({
        'hostelId': expense.hostelId,
        'hostelName': expense.hostelName,
        'amount': expense.amount,
        'description': expense.description,
        'date': Timestamp.fromDate(expense.date),
      });
    } catch (e) {
      throw ServerException('Failed to add expense: $e');
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      await firestore.collection('expenses').doc(id).delete();
    } catch (e) {
      throw ServerException('Failed to delete expense: $e');
    }
  }
}