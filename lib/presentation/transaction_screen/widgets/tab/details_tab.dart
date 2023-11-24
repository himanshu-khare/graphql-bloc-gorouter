import 'package:flutter/material.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/core/utils/widget_utils.dart';
import 'package:servicesapp/presentation/home_page_screen/bloc/home_page_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Column(
      children: [
        buildHomeData(cubit.state as HomeDataState),
      ],
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

}
