import 'package:go_router/go_router.dart';
import 'package:servicesapp/core/utils/widget_utils.dart';
import 'package:servicesapp/presentation/accounts_screen/bloc/accounts_page_bloc.dart';
import 'package:servicesapp/widgets/app_bar/appbar_title.dart';
import 'package:servicesapp/widgets/app_bar/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:servicesapp/core/app_export.dart';

class AccountPageScreen extends StatelessWidget {
  AccountPageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context, GoRouterState state) {
    return BlocProvider<AccountsPageCubit>(
        create: (context) {
          return AccountsPageCubit();
        },
        lazy: false,
        child: AccountPageScreen());
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_accounts".tr),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<AccountsPageCubit, AccountsPageState>(
          builder: (context, state) {
            if (state is AccountLoadingState) {
              return CircularProgressIndicator.adaptive().centered();
            }
            if (state is AccountErrorState) {
              return Text(state.error).centered();
            }
            if (state is AccountDataState) {
              return SingleChildScrollView(
                child: buildTransaction(context, state).p8(),
              );
            }
            return SizedBox.shrink();
          },
        ));
  }

  Widget buildTransaction(BuildContext context, AccountDataState state) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(state.accounts?.length ?? 0, (index) {
          final account = state.accounts![index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildKeyValue("Account Number", account.accountNumber),
                buildKeyValue("Account Type", account.accountNumber),
                buildKeyValue("Balance", account.balance?.toString()),
                buildKeyValue(
                    "accountHolder", account.accountHolder?.toString()),
              ],
            ).p(10),
          ).onInkTap(() {
            GoRouter.of(context).go(
                '${AppRoutes.accountsPageScreen + "/${AppRoutes.transactionPageScreen}"}',
                extra: account);
          });
        })).p(10);
  }

}
