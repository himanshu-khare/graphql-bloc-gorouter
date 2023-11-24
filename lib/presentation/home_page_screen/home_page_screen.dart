import 'package:go_router/go_router.dart';
import 'package:servicesapp/core/utils/widget_utils.dart';
import 'package:velocity_x/velocity_x.dart';

import 'bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/widgets/app_bar/appbar_title.dart';
import 'package:servicesapp/widgets/app_bar/custom_app_bar.dart';
import 'package:servicesapp/widgets/custom_bottom_bar.dart';

class MainPageScreen extends StatelessWidget {
  MainPageScreen({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocProvider(
        create: (context) => HomePageCubit(),
        child: Scaffold(
            body: child, bottomNavigationBar: _buildBottomBar(context)),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      switch (type.index) {
        case 1:
          GoRouter.of(context).go(AppRoutes.accountsPageScreen);
          break;
        case 2:
          GoRouter.of(context).go(AppRoutes.servicesPageScreen);
          break;
        case 0:
        default:
          GoRouter.of(context).go(AppRoutes.homePageScreen);
          break;
      }
    });
  }
}

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key,this.title}) : super(key: key);
 final String? title;
  static Widget builder(BuildContext context, GoRouterState state) {
    return HomePageScreen(title:state.extra?.toString()??"");
  }

  PreferredSizeWidget buildAppBar(String title) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: buildAppBar(title??""),
        body: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return CircularProgressIndicator.adaptive().centered();
            }
            if (state is HomeErrorState) {
              return Text(state.error).centered();
            }
            if (state is HomeDataState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHomeData(state),
                    10.heightBox,
                    buildAddress(state),
                    10.heightBox,
                    buildTransaction(state),
                    10.heightBox,
                    buildBills(state),
                  ],
                ).p8(),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Card buildHomeData(HomeDataState state) {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildKeyValue("Name", state.homeData.name),
            buildKeyValue("Account Number", state.homeData.accountNumber),
            buildKeyValue("Balance", state.homeData.balance?.toString()),
            buildKeyValue("Currency", state.homeData.currency),
          ]).p(10),
    );
  }

  Card buildAddress(HomeDataState state) {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildKeyValue("Street Name", state.homeData.address?.streetName),
            buildKeyValue(
                "Building Number", state.homeData.address?.buildingNumber),
            buildKeyValue("Town Name", state.homeData.address?.townName),
            buildKeyValue("Post Code", state.homeData.address?.postCode),
            buildKeyValue("Country", state.homeData.address?.country),
          ]).p(10),
    );
  }

  Card buildTransaction(HomeDataState state) {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              state.homeData.recentTransactions?.length ?? 0, (index) {
            final transactions = state.homeData.recentTransactions![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildKeyValue("Date", transactions.date),
                buildKeyValue("Description", transactions.description),
                buildKeyValue("Amount", transactions.amount?.toString()),
                buildKeyValue(
                    "From Account", transactions.fromAccount?.toString()),
                buildKeyValue("To Account", transactions.toAccount?.toString()),
                20.heightBox,
              ],
            );
          })).p(10),
    );
  }

  Card buildBills(HomeDataState state) {
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              List.generate(state.homeData.upcomingBills?.length ?? 0, (index) {
            final bill = state.homeData.upcomingBills![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildKeyValue("Date", bill.date),
                buildKeyValue("Description", bill.description),
                buildKeyValue("Amount", bill.amount?.toString()),
                buildKeyValue("From Account", bill.fromAccount?.toString()),
                buildKeyValue("To Account", bill.toAccount?.toString()),
                20.heightBox,
              ],
            );
          })).p(10),
    );
  }

}
