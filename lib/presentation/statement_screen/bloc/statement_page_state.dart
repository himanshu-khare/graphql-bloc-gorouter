import 'package:servicesapp/data/models/statements_data/statement.dart';

abstract class StatementPageState {}

class StatementPageInitialState extends StatementPageState {}

class StatementPageLoadingState extends StatementPageState {}

class StatementPageErrorState extends StatementPageState {
  final String message;
  StatementPageErrorState(this.message);
}

class StatementPageDataState extends StatementPageState {
  final List<Statement>? statements;
  final List<Statement>? allstatements;
  StatementPageDataState(this.statements,[this.allstatements]);
}
