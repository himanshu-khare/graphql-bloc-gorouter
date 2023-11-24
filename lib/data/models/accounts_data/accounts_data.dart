import 'account.dart';

class AccountsData {
  List<Account>? accounts;

  AccountsData({this.accounts});

  factory AccountsData.fromJson(Map<String, dynamic> json) => AccountsData(
        accounts: (json['accounts'] as List<dynamic>?)
            ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'accounts': accounts?.map((e) => e.toJson()).toList(),
      };
}
