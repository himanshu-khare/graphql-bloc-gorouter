import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:gql/src/ast/ast.dart';
import 'package:servicesapp/data/apiClient/api_client.dart';
import 'package:servicesapp/data/models/statements_data/statements_data.dart';
import 'package:servicesapp/presentation/statement_screen/bloc/statement_page_state.dart';

class StatementPageCubit extends Cubit<StatementPageState> {
  StatementPageCubit() : super(StatementPageInitialState()) {
    onInitialize();
  }
  final List<String> dateListArray = List.generate(4, (index) {
    return 2019 + index;
  }).map((e) => e.toString()).toList()
    ..insert(0, "All");

  onInitialize() {
    getContactsData();
  }

  late String selected = dateListArray.first;

  filterList(String? val) {
    selected = val??"All";
    if (val == null) {
      return;
    }
    if (val == "All") {
      emit(StatementPageDataState(
          (state as StatementPageDataState).allstatements,(state as StatementPageDataState)
        .allstatements));
      return;
    }
    final list = (state as StatementPageDataState)
        .allstatements
        ?.where((element) => element.date?.contains(val) == true)
        .toList();
    emit(StatementPageDataState(list,(state as StatementPageDataState)
        .allstatements));
  }

  getContactsData() async {
    DocumentNode query = statementsQuery();
    emit(StatementPageLoadingState());
    final QueryResult result =
        await ApiClient.client.query(QueryOptions(document: query));
    if (result.hasException) {
      final msg = result.exception?.graphqlErrors.first.message;

      emit(StatementPageErrorState(msg ?? "Something went wrong"));
    } else {
      final accountsData = StatementsData.fromJson(result.data!);
      emit(StatementPageDataState(
          accountsData.statements ?? [], accountsData.statements ?? []));
    }
  }

  DocumentNode statementsQuery() {
    final query = gql('''
query getStatements {
  statements {
    date
    description
    amount
  }
}
''');
    return query;
  }
}
