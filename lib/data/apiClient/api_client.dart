import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:servicesapp/core/app_export.dart';


class ApiClient {
  static final client = GraphQLClient(
    link: HttpLink(
      graphapi,
    ),
    cache: GraphQLCache(),
   
  );
}
