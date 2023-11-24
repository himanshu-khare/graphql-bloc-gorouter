import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:servicesapp/core/app_export.dart';
import 'package:servicesapp/data/apiClient/api_client.dart';

part 'contact_page_state.dart';

class ContactsPageCubit extends Cubit<ContactsPageState> {
  ContactsPageCubit() : super(ContactsPageInitial()) {
    onInitialize();
  }

  onInitialize() {
    getContactsData();
  }

  getContactsData() async {
    DocumentNode query = contactsQuery();
    emit(ContactsPageLoadingState());
    final QueryResult result =
        await ApiClient.client.query(QueryOptions(document: query));
    if (result.hasException) {
    final msg =  result.exception?.graphqlErrors.first.message;
      emit(ContactsPageErrorState(
          msg ?? "Something went wrong"));
    } else {
      emit(ContactsPageDataState("Contacts data loaded"));
    }
  }

  DocumentNode contactsQuery() {
    final query = gql('''
query getContacts {
  contacts
}
''');
    return query;
  }
}
