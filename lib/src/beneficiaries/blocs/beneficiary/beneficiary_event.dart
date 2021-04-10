part of 'beneficiary_bloc.dart';

@immutable
abstract class BeneficiaryEvent extends Equatable {
  const BeneficiaryEvent();
}

@immutable
class GetBeneficiaries extends BeneficiaryEvent {
  @override
  List<Object> get props => [];
}

@immutable
class FilterEvent extends BeneficiaryEvent {
  final List<Beneficiary>  filterResult;
  FilterEvent(this.filterResult);

  @override
  List<Object> get props => [filterResult];
}

@immutable
class PickBeneficiary extends BeneficiaryEvent {
  final Beneficiary  beneficiary;
  PickBeneficiary(this.beneficiary);

  @override
  List<Object> get props => [beneficiary];
}

@immutable
class CreateNewBeneficiary extends BeneficiaryEvent {
  @override
  List<Object> get props => [];
}

@immutable
class SwitchToPickBeneficiary extends BeneficiaryEvent {
  @override
  List<Object> get props => [];
}
