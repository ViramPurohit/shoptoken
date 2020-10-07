import 'package:Retailer/views/customerlist/bloc/customer_bloc.dart';
import 'package:Retailer/views/customerlist/bloc/customer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'customerList_result.dart';

class CustomerList extends StatelessWidget {
  CustomerList();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      // bloc: BlocProvider.of<NearestStoreBloc>(context),
      builder: (BuildContext context, CustomerState state) {
        if (state is CustomerFailure) {
          return Text(state.error);
        }
        if (state is CustomerSuccess) {
          return state.result.nearshopresult.isError == 0
              ? Expanded(
                  child: CustomerListResult(
                    slotsList: state.result.nearshopresult.data,
                  ),
                )
              : Text('No shop added with your area...');
        }
        if (state is CodeVerificationSuccess) {
          return state.result.nearshopresult.isError == 0
              ? Expanded(
                  child: CustomerListResult(
                    slotsList: state.result.nearshopresult.data,
                  ),
                )
              : Text('No shop added with your area...');
        } else {
          return Expanded(
            child: Text('Fetching slots...'),
          );
        }
      },
    );
  }
}
