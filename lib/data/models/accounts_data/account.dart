class Account {
  String? id;
  String? accountNumber;
  String? accountType;
  double? balance;
  String? accountHolder;

  Account({
    this.id,
    this.accountNumber,
    this.accountType,
    this.balance,
    this.accountHolder,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json['id'] as String?,
        accountNumber: json['accountNumber'] as String?,
        accountType: json['accountType'] as String?,
        balance: (json['balance'] as num?)?.toDouble(),
        accountHolder: json['accountHolder'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'accountNumber': accountNumber,
        'accountType': accountType,
        'balance': balance,
        'accountHolder': accountHolder,
      };
}
