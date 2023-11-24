import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/main.dart';
import 'package:servicesapp/widgets/app_bar/appbar_title.dart';
import 'package:servicesapp/widgets/app_bar/custom_app_bar.dart';
import 'package:servicesapp/widgets/custom_elevated_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ServicesPageScreen extends StatelessWidget {
  const ServicesPageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context, GoRouterState state) {
    return ServicesPageScreen();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(text: "lbl_services".tr),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomElevatedButton(
              text: "lbl_loans".tr,
              onPressed: () {
                if (globalMessengerKey.currentState != null) {
                  globalMessengerKey.currentState!.showSnackBar(
                      SnackBar(content: Text("Loans Coming soon!!")));
                }
              },
              buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
              buttonTextStyle: TextStyle(color: appTheme.black)),
          10.h.heightBox,
          CustomElevatedButton(
              text: "lbl_statememts".tr,
              onPressed: () {
               GoRouter.of(context).go(
                '${AppRoutes.servicesPageScreen + "/${AppRoutes.statementPageScreen}"}',
               );
              },
              buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
              buttonTextStyle: TextStyle(color: appTheme.black)),
          10.h.heightBox,
          CustomElevatedButton(
              text: "lbl_contacts".tr,
              onPressed: () {
                 GoRouter.of(context).go(
                '${AppRoutes.servicesPageScreen + "/${AppRoutes.contactPageScreen}"}',
               );
              },
              buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
              buttonTextStyle: TextStyle(color: appTheme.black))
        ],
      ).p(10),
    );
  }
}
