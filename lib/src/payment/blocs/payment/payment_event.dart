part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

@immutable
class SaveExpense extends PaymentEvent {
  final Expense expense;

  SaveExpense(this.expense);
  @override
  List<Object> get props => [expense];
}

@immutable
class GetPaymentMethods extends PaymentEvent {
  @override
  List<Object> get props => [];
}

@immutable
class UpdatePaystackCheckoutEvent extends PaymentEvent {
  final PaymentMethod paymentMethod;
  final String reference;
  UpdatePaystackCheckoutEvent(this.paymentMethod, this.reference);
  @override
  List<Object> get props => [paymentMethod, reference];
}

@immutable
class GetSavedPaymentMethods extends PaymentEvent {
  @override
  List<Object> get props => [];
}
