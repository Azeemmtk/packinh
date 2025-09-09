import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/entity/hostel_entity.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../domain/entity/expense.dart';
import '../../../../domain/usecases/add_expense_use_case.dart';
import '../../../../domain/usecases/delete_expense_use_case.dart';
import '../../../../domain/usecases/fetch_expense_use_case.dart';
import '../../../../domain/usecases/fetch_hostel_usecase.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final FetchHostelsUseCase fetchHostelsUseCase;
  final FetchExpensesUseCase fetchExpensesUseCase;
  final AddExpenseUseCase addExpenseUseCase;
  final DeleteExpenseUseCase deleteExpenseUseCase;

  List<HostelEntity> hostels = [];
  Map<String, List<Expense>> expensesByHostel = {};

  ExpenseBloc({
    required this.fetchHostelsUseCase,
    required this.fetchExpensesUseCase,
    required this.addExpenseUseCase,
    required this.deleteExpenseUseCase,
  }) : super(ExpenseInitial()) {
    on<FetchExpensesData>(_onFetchExpensesData);
    on<AddExpense>(_onAddExpense);
    on<DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onFetchExpensesData(
      FetchExpensesData event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());

    final hostelsResult = await fetchHostelsUseCase();
    await hostelsResult.fold(
          (failure) async => emit(ExpenseError(_mapFailureToMessage(failure))),
          (fetchedHostels) async {
        hostels = fetchedHostels;
        final hostelIds = hostels.map((h) => h.id).toList();
        final expensesResult = await fetchExpensesUseCase(hostelIds);
        expensesResult.fold(
              (failure) => emit(ExpenseError(_mapFailureToMessage(failure))),
              (expenses) {
            expensesByHostel = {};
            for (var expense in expenses) {
              expensesByHostel.update(
                expense.hostelId,
                    (list) => list..add(expense),
                ifAbsent: () => [expense],
              );
            }
            emit(ExpenseLoaded());
          },
        );
      },
    );
  }

  Future<void> _onAddExpense(AddExpense event, Emitter<ExpenseState> emit) async {
    final result = await addExpenseUseCase(event.expense);
    result.fold(
          (failure) => emit(ExpenseError(_mapFailureToMessage(failure))),
          (_) {
        add(FetchExpensesData()); // Refresh data
      },
    );
  }

  Future<void> _onDeleteExpense(
      DeleteExpense event, Emitter<ExpenseState> emit) async {
    final result = await deleteExpenseUseCase(event.id);
    result.fold(
          (failure) => emit(ExpenseError(_mapFailureToMessage(failure))),
          (_) {
        add(FetchExpensesData()); // Refresh data
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      default:
        return 'Unexpected error';
    }
  }
}