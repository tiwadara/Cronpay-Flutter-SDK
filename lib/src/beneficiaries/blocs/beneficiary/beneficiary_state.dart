part of 'beneficiary_bloc.dart';

@immutable
abstract class BeneficiaryState extends Equatable {
  const BeneficiaryState();
}

class InitialBeneficiaryState extends BeneficiaryState {
  @override
  List<Object> get props => [];
}

@immutable
class ErrorMessageState extends BeneficiaryState {
  final String error;
  ErrorMessageState(this.error);
  @override
  List<Object> get props => [error];
}

@immutable
class RequestError extends BeneficiaryState {
  final ErrorResponse errorResponse;
  RequestError(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}

class FilteringState extends BeneficiaryState {
  @override
  List<Object> get props => [];
}

@immutable
class FilteredState extends BeneficiaryState {
  final List<Beneficiary> filterResult;
  FilteredState(this.filterResult);

  @override
  List<Object> get props => [filterResult];
}

@immutable
class GettingBeneficiaries extends BeneficiaryState {
  @override
  List<Object> get props => [];
}

@immutable
class BeneficiariesReturned extends BeneficiaryState {
  final List<Beneficiary> beneficiaries;
  BeneficiariesReturned(this.beneficiaries);

  @override
  List<Object> get props => [beneficiaries];
}

@immutable
class BeneficiaryPicked extends BeneficiaryState {
  final Beneficiary beneficiary;
  BeneficiaryPicked(this.beneficiary);

  @override
  List<Object> get props => [beneficiary];
}

@immutable
class CreateNewPicked extends BeneficiaryState {

  @override
  List<Object> get props => [];
}

@immutable
class SwitchToExistingPicked extends BeneficiaryState {

  @override
  List<Object> get props => [];
}

