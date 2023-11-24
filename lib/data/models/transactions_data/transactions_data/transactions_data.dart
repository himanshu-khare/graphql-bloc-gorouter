import 'transaction.dart';

class TransactionsData {
  List<Transaction>? transactions;

  TransactionsData({this.transactions});

  factory TransactionsData.fromJson(Map<String, dynamic> json) {
    return TransactionsData(
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'transactions': transactions?.map((e) => e.toJson()).toList(),
      };
}
