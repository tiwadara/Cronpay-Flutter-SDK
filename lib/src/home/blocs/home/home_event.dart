part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

@immutable
class SaveExpense extends HomeEvent {
  final Expense expense;

  SaveExpense(this.expense);
  @override
  List<Object> get props => [expense];
}

@immutable
class SaveBudget extends HomeEvent {
  final Budget budget;

  SaveBudget(this.budget);
  @override
  List<Object> get props => [budget];
}

@immutable
class GetExpenses extends HomeEvent {
  GetExpenses();
  @override
  List<Object> get props => [];
}

@immutable
class GetBudget extends HomeEvent {
  GetBudget();
  @override
  List<Object> get props => [];
}

@immutable
class GetFilteredExpenses extends HomeEvent {
  final String category;
  GetFilteredExpenses(this.category);
  @override
  List<Object> get props => [category];
}





