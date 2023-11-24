import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/data/apiClient/api_client.dart';
import 'package:servicesapp/data/models/transactions_data/transactions_data/transaction.dart';
import 'package:gql/src/ast/ast.dart';
import 'package:servicesapp/data/models/transactions_data/transactions_data/transactions_data.dart';
part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial()) {
    onInitialize();
  }

  onInitialize() {
    getTransactionsData();
  }

  getTransactionsData() async {
    DocumentNode query = transactionsQuery();
    emit(TransactionLoadingState());
    final QueryResult result =
        await ApiClient.client.query(QueryOptions(document: query));
    if (result.hasException) {
      emit(TransactionErrorState(
          result.exception?.toString() ?? "Something went wrong"));
    } else {
      final transactionData = TransactionsData.fromJson(result.data!);
      emit(TransactionDataState(transactionData.transactions ?? []));
    }
  }

  DocumentNode transactionsQuery() {
    final query = gql('''
query getTransactions {
  transactions {
    date
    description
    amount
    fromAccount
    toAccount
  }
}
''');
    return query;
  }
}
