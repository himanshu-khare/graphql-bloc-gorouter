import 'package:flutter/material.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/presentation/transaction_screen/bloc/transaction_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionTab extends StatelessWidget {
  const TransactionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadingState) {
          return CircularProgressIndicator.adaptive().centered();
        }
        if (state is TransactionErrorState) {
          return Text(state.error).centered();
        }
        if (state is TransactionDataState) {
          return SingleChildScrollView(
            child: buildTransaction(context, state).p8(),
          );
        }
        return SizedBox.shrink();
      },
    ));
  }

  Widget buildTransaction(BuildContext context, TransactionDataState state) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(state.data.length, (index) {
          final transaction = state.data[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildKeyValue("Date", transaction.date),
                buildKeyValue("Description", transaction.description),
                buildKeyValue("Amount", transaction.amount?.toString()),
                buildKeyValue("From Account", transaction.fromAccount),
                buildKeyValue("To Account", transaction.toAccount),
              ],
            ).p(10),
          );
        })).p(10);
  }

  Widget buildKeyValue(String key, String? value) {
    return Text(
      "${key} ${value}",
      style: TextStyle(color: appTheme.black),
    ).w(mediaQueryData.size.width);
  }
}
