class Statement {
  String? date;
  String? description;
  double? amount;

  Statement({this.date, this.description, this.amount});

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
        date: json['date'] as String?,
        description: json['description'] as String?,
        amount: (json['amount'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'description': description,
        'amount': amount,
      };
}
