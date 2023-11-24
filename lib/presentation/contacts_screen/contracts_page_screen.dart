import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/presentation/contacts_screen/bloc/contact_page_bloc.dart';
import 'package:servicesapp/widgets/app_bar/appbar_title.dart';
import 'package:servicesapp/widgets/app_bar/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class ContractsPageScreen extends StatelessWidget {
  const ContractsPageScreen({Key? key}) : super(key: key);
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_contacts".tr),
    );
  }

  static Widget builder(BuildContext context, GoRouterState state) {
    return BlocProvider<ContactsPageCubit>(
        create: (context) {
          return ContactsPageCubit();
        },
        lazy: false,
        child: ContractsPageScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<ContactsPageCubit, ContactsPageState>(
          builder: (context, state) {
            if (state is ContactsPageLoadingState) {
              return CircularProgressIndicator.adaptive().centered();
            }
            if (state is ContactsPageErrorState) {
              return Text(state.error).centered();
            }
            if (state is ContactsPageDataState) {
              return Text(state.data);
            }
            return SizedBox.shrink();
          },
        ));
  }
}
