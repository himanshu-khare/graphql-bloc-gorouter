import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/data/models/accounts_data/account.dart';
import 'package:servicesapp/presentation/transaction_screen/bloc/transaction_cubit.dart';
import 'package:servicesapp/presentation/transaction_screen/widgets/tab/details_tab.dart';
import 'package:servicesapp/presentation/transaction_screen/widgets/tab/transaction_tab.dart';
import 'package:servicesapp/widgets/app_bar/appbar_title.dart';
import 'package:servicesapp/widgets/app_bar/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionPageScreen extends StatelessWidget {
  const TransactionPageScreen({Key? key, required this.account})
      : super(key: key);

  final Account account;

  static Widget builder(BuildContext context, GoRouterState state) {
    final Account account = state.extra as Account;
    return BlocProvider<TransactionCubit>(
        create: (context) {
          return TransactionCubit();
        },
        lazy: false,
        child: TransactionPageScreen(
          account: account,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text("Acount No: ${account.accountNumber}"),
            Text("Balance: ${account.balance.toString()}"),
          ]),
          20.h.heightBox,
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: appTheme.black,
                  tabs: [
                    Tab(icon: Text("Transactions")),
                    Tab(icon: Text("Details")),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    // <-- Your TabBarView
                    children: [
                      TransactionTab(),
                      DetailsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ).expand()
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_transaction".tr),
    );
  }
}
