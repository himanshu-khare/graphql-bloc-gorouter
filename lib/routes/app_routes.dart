import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesapp/presentation/accounts_screen/accounts_page_screen.dart';
import 'package:servicesapp/presentation/contacts_screen/contracts_page_screen.dart';
import 'package:servicesapp/presentation/login_screen/login_screen.dart';
import 'package:servicesapp/presentation/home_page_screen/home_page_screen.dart';
import 'package:servicesapp/presentation/services_screen/services_page_screen.dart';
import 'package:servicesapp/presentation/statement_screen/statement_page_screen.dart';
import 'package:servicesapp/presentation/transaction_screen/widgets/transactions_page_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String homePageScreen = '/home_page_screen';

  static const String accountsPageScreen = '/accounts_page_screen';

  static const String servicesPageScreen = '/services_page_screen';

  static const String transactionPageScreen = 'transaction_page_screen';

  static const String contactPageScreen = 'contact_page_screen';

  static const String statementPageScreen = 'statement_page_screen';


  static GoRouter routes = GoRouter(
    initialLocation: loginScreen,
    routes: [
      GoRoute(
        path: loginScreen,
        builder: LoginScreen.builder,
      ),
      ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return MainPageScreen(
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: homePageScreen,
              builder: HomePageScreen.builder,
            ),
            GoRoute(
                path: accountsPageScreen,
                builder: AccountPageScreen.builder,
                routes: [
                  GoRoute(
                      path: transactionPageScreen,
                      builder: TransactionPageScreen.builder)
                ]),
            GoRoute(
              path: servicesPageScreen,
              builder: ServicesPageScreen.builder,
              routes: [
                   GoRoute(
                      path: contactPageScreen,
                      builder: ContractsPageScreen.builder),
                         GoRoute(
                      path: statementPageScreen,
                      builder: StatementPageScreen.builder)
              ]
            ),
          ])
    ],
  );
}
