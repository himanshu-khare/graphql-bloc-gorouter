import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/presentation/accounts_screen/bloc/accounts_page_bloc.dart';
import 'package:servicesapp/presentation/home_page_screen/bloc/home_page_bloc.dart';
import 'package:servicesapp/presentation/home_page_screen/home_page_screen.dart';
import 'package:servicesapp/presentation/services_screen/services_page_screen.dart';

void main() {
  group('AccountRepository', () {
    test('Lst of accounts', () async {
      // Mock the GraphQL query response
      final result = await AccountRepository.fetchAccount();
      expect(result?.isNotEmpty, true);
    });

    testWidgets('Home Screen Test', (tester) async {
      // Build the CustomAppBar widget
      await tester.pumpWidget(BlocProvider(
        create: (context) => HomePageCubit(),
        child: MaterialApp(home: HomePageScreen()),
      ));
      // Find the AppBar title and verify its text
      expect(find.text("Dashboard"), findsOneWidget);
    });

    testWidgets('Services Screen Test', (tester) async {
      // Build the CustomAppBar widget
      await tester.pumpWidget(MaterialApp(home: ServicesPageScreen()));
      // Find the AppBar title and verify its text
      expect(find.text("Loans"), findsOneWidget);
      expect(find.text("Statements"), findsOneWidget);
      expect(find.text("Contacts"), findsOneWidget);
    });

  });
}
