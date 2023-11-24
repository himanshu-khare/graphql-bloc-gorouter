// ignore_for_file: must_be_immutable

part of 'accounts_page_bloc.dart';

/// Represents the state of HomePage in the application.
class AccountsPageState {}

class AccountDataState extends AccountsPageState {
  List<Account>? accounts;
  AccountDataState(this.accounts);
}

class AccountLoadingState extends AccountsPageState {}

class AccountErrorState extends AccountsPageState {
  final String error;
  AccountErrorState(this.error);
}
