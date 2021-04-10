import 'package:cron_pay/src/beneficiaries/blocs/beneficiary/beneficiary_bloc.dart';
import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';
import 'package:cron_pay/src/beneficiaries/widgets/beneficiary_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeneficiaryList extends StatefulWidget {
  const BeneficiaryList({
    Key key,
    @required this.beneficiaries,
  }) : super(key: key);

  final List<Beneficiary> beneficiaries;

  @override
  _BeneficiaryListState createState() => _BeneficiaryListState();
}

class _BeneficiaryListState extends State<BeneficiaryList> {
  BeneficiaryBloc _beneficiaryBloc;

  @override
  void initState() {
    _beneficiaryBloc = BlocProvider.of<BeneficiaryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.beneficiaries.length,
        itemBuilder: (context, position) {
          return BeneficiaryListItem(
            icon: Icons.add_circle_outline,
            beneficiary: widget.beneficiaries[position],
            color: Colors.white,
            position: position,
            onPressed: () {
              _beneficiaryBloc.add(PickBeneficiary(widget.beneficiaries[position]));
              Navigator.pop(context);
            },
          );
        });
  }
}
