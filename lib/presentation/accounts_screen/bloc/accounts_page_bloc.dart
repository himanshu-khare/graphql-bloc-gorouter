import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:servicesapp/data/apiClient/api_client.dart';
import 'package:servicesapp/data/models/accounts_data/account.dart';
import 'package:servicesapp/data/models/accounts_data/accounts_data.dart';
import '/core/app_export.dart';
part 'accounts_page_state.dart';

class AccountsPageCubit extends Cubit<AccountsPageState> {
  AccountsPageCubit() : super(AccountsPageState()) {
    onInitialize();
  }

  onInitialize() {
    getAccountsData();
  }

  getAccountsData() async {
    emit(AccountLoadingState());
    try {
      final result = await AccountRepository.fetchAccount();
      emit(AccountDataState(result));
    } on Exception catch (err) {
      emit(AccountErrorState(err.toString()));
    }
  }
}

class AccountRepository {
  static Future<List<Account>?> fetchAccount() async {
    final result =
        await ApiClient.client.query(QueryOptions(document: _accountsQuery()));
    if (result.hasException) {
      return [];
    }
    final accountsData = AccountsData.fromJson(result.data!);
    return accountsData.accounts;
  }

  static DocumentNode _accountsQuery() {
    final query = gql('''
 query getAccounts {
  accounts {
    id
    accountNumber
    accountType
    balance
    accountHolder
  }
}
''');
    return query;
  }
}
