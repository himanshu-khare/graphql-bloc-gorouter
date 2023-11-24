class UpcomingBill {
  String? date;
  String? description;
  double? amount;
  String? fromAccount;
  String? toAccount;

  UpcomingBill({
    this.date,
    this.description,
    this.amount,
    this.fromAccount,
    this.toAccount,
  });

  factory UpcomingBill.fromJson(Map<String, dynamic> json) => UpcomingBill(
        date: json['date'] as String?,
        description: json['description'] as String?,
        amount: (json['amount'] as num?)?.toDouble(),
        fromAccount: json['fromAccount'] as String?,
        toAccount: json['toAccount'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'description': description,
        'amount': amount,
        'fromAccount': fromAccount,
        'toAccount': toAccount,
      };
}
