part of 'payment_bloc.dart';

@immutable
abstract class PaymentState extends Equatable {
  const PaymentState();
}

class InitialPaymentState extends PaymentState {
  @override
  List<Object> get props => [];
}
@immutable
class CardFailed extends PaymentState {
  final String error;
  CardFailed(this.error);
  @override
  List<Object> get props => [error];
}

class SendingReference extends PaymentState {
  @override
  List<Object> get props => [];
}

@immutable
class PaymentMethodReceived extends PaymentState {
  final List<PaymentMethod> paymentMethods;
  PaymentMethodReceived(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

@immutable
class CardAddedSuccessfully extends PaymentState {
  final String  message;
  CardAddedSuccessfully(this.message);

  @override
  List<Object> get props => [message];
}

@immutable
class SavedCardsReceived extends PaymentState {
  final List<PaymentMethod>  paymentMethods;
  SavedCardsReceived(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];
}

