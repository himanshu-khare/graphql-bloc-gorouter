class RecentTransaction {
  String? date;
  String? description;
  int? amount;
  String? fromAccount;
  String? toAccount;

  RecentTransaction({
    this.date,
    this.description,
    this.amount,
    this.fromAccount,
    this.toAccount,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) {
    return RecentTransaction(
      date: json['date'] as String?,
      description: json['description'] as String?,
      amount: json['amount'] as int?,
      fromAccount: json['fromAccount'] as String?,
      toAccount: json['toAccount'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'description': description,
        'amount': amount,
        'fromAccount': fromAccount,
        'toAccount': toAccount,
      };
}
