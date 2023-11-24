import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:servicesapp/data/apiClient/api_client.dart';
import 'package:servicesapp/data/models/home/home_data/home_data.dart';
import '/core/app_export.dart';
part 'home_page_state.dart';

/// A bloc that manages the state of a HomePage according to the event that is dispatched to it.
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState()) {
    onInitialize();
  }

  onInitialize() {
    getHomeData();
  }

  getHomeData() async {
    DocumentNode query = homeQuery();
    emit(HomeLoadingState());
    final QueryResult result =
        await ApiClient.client.query(QueryOptions(document: query));
    if (result.hasException) {
      emit(HomeErrorState(
          result.exception?.toString() ?? "Something went wrong"));
    } else {
      final homeData = HomeData.fromJson(result.data!['home']);
      emit(HomeDataState(homeData));
    }
  }

  DocumentNode homeQuery() {
    final query = gql('''
  query getHome {
    home {
      name
      accountNumber
      balance
      currency
      address {
        streetName
        buildingNumber
        townName
        postCode
        country
      }
      recentTransactions {
        date
        description
        amount
        fromAccount
        toAccount
      }
      upcomingBills {
        date
        description
        amount
        fromAccount
        toAccount
      }
    }
  }
''');
    return query;
  }
}
