// ignore_for_file: must_be_immutable

part of 'transaction_cubit.dart';

/// Represents the state of HomePage in the application.
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionErrorState extends TransactionState {
  final String error;
  TransactionErrorState(this.error);
}

class TransactionDataState extends TransactionState {
  final List<Transaction> data;
  TransactionDataState(this.data);
}
