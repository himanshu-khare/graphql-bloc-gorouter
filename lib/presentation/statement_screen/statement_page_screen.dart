import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/core/utils/widget_utils.dart';
import 'package:servicesapp/presentation/statement_screen/bloc/statement_page_bloc.dart';
import 'package:servicesapp/presentation/statement_screen/bloc/statement_page_state.dart';
import 'package:servicesapp/widgets/app_bar/appbar_title.dart';
import 'package:servicesapp/widgets/app_bar/custom_app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:velocity_x/velocity_x.dart';

class StatementPageScreen extends StatelessWidget {
  const StatementPageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context, GoRouterState state) {
    return BlocProvider<StatementPageCubit>(
        create: (context) {
          return StatementPageCubit();
        },
        lazy: false,
        child: StatementPageScreen());
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_statememts".tr),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<StatementPageCubit, StatementPageState>(
          builder: (context, state) {
            final cubit = context.read<StatementPageCubit>();
            if (state is StatementPageLoadingState) {
              return CircularProgressIndicator.adaptive().centered();
            }
            if (state is StatementPageErrorState) {
              return Text(state.message).centered();
            }
            if (state is StatementPageDataState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VxTextDropDown(cubit.dateListArray,
                        selectedValue: cubit.selected, onChanged: (val) {
                      cubit.filterList(val);
                    }).make(),
                    buildTransaction(context, state).p8(),
                  ],
                ).w(double.infinity),
              );
            }
            return SizedBox.shrink();
          },
        ));
  }

  Widget buildTransaction(BuildContext context, StatementPageDataState state) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(state.statements?.length ?? 0, (index) {
          final account = state.statements![index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildKeyValue("Date", account.date),
                buildKeyValue("Description", account.description),
                buildKeyValue("Amount", account.amount?.toString()),
              ],
            ).p(10),
          ).onInkTap(() {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: ((context) {
                  return Scaffold(
                    body: SfPdfViewer.network(
                        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
                  );
                }));
          });
        })).p(10);
  }

}
