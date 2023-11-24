import 'statement.dart';

class StatementsData {
  List<Statement>? statements;

  StatementsData({this.statements});

  factory StatementsData.fromJson(Map<String, dynamic> json) {
    return StatementsData(
      statements: (json['statements'] as List<dynamic>?)
          ?.map((e) => Statement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'statements': statements?.map((e) => e.toJson()).toList(),
      };
}
