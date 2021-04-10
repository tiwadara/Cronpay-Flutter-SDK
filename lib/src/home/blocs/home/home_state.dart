part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialWalletState extends HomeState {
  @override
  List<Object> get props => [];
}
@immutable
class ErrorWithMessageState extends HomeState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

@immutable
class SavingExpense extends HomeState {
  @override
  List<Object> get props => [];
}

@immutable
class GettingExpenses extends HomeState {
  @override
  List<Object> get props => [];
}

@immutable
class ExpenseAdded extends HomeState {
  final List<Expense> expenses;
  ExpenseAdded(this.expenses);

  @override
  List<Object> get props => [expenses];
}

@immutable
class BudgetAdded extends HomeState {
  final List<Budget> budget;
  BudgetAdded(this.budget);

  @override
  List<Object> get props => [budget];
}

@immutable
class BudgetListReturned extends HomeState {
  final List<Budget> budget;
  BudgetListReturned(this.budget);

  @override
  List<Object> get props => [budget];
}

@immutable
class ExpenseFiltered extends HomeState {
  final List<Expense> expenses;
  ExpenseFiltered(this.expenses);

  @override
  List<Object> get props => [expenses];
}

@immutable
class ExpensesReturned extends HomeState {
  final List<Expense> expenses;
  ExpensesReturned(this.expenses);

  @override
  List<Object> get props => [expenses];
}
