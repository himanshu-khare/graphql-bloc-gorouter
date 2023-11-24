import 'address.dart';
import 'recent_transaction.dart';
import 'upcoming_bill.dart';

class HomeData {
  String? name;
  String? accountNumber;
  double? balance;
  String? currency;
  Address? address;
  List<RecentTransaction>? recentTransactions;
  List<UpcomingBill>? upcomingBills;

  HomeData({
    this.name,
    this.accountNumber,
    this.balance,
    this.currency,
    this.address,
    this.recentTransactions,
    this.upcomingBills,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        name: json['name'] as String?,
        accountNumber: json['accountNumber'] as String?,
        balance: (json['balance'] as num?)?.toDouble(),
        currency: json['currency'] as String?,
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String, dynamic>),
        recentTransactions: (json['recentTransactions'] as List<dynamic>?)
            ?.map((e) => RecentTransaction.fromJson(e as Map<String, dynamic>))
            .toList(),
        upcomingBills: (json['upcomingBills'] as List<dynamic>?)
            ?.map((e) => UpcomingBill.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
        'balance': balance,
        'currency': currency,
        'address': address?.toJson(),
        'recentTransactions':
            recentTransactions?.map((e) => e.toJson()).toList(),
        'upcomingBills': upcomingBills?.map((e) => e.toJson()).toList(),
      };
}
