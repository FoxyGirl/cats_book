import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:cats_book/import.dart';

// ignore: uri_does_not_exist
// import '../local.dart';

const _kEnableWebsockets = false;

class DatabaseRepository {
  DatabaseRepository({GraphQLClient client}) : _client = client ?? _getClient();

  final GraphQLClient _client;

  Future<List<UnitModel>> readUnits({@required CategoryKey categoryId}) async {
    assert(categoryId != null);
    final options = QueryOptions(
      documentNode: _API.readUnits,
      variables: {
        'category_id': convertEnumToSnakeCase(categoryId),
      },
      fetchPolicy: FetchPolicy.noCache,
      errorPolicy: ErrorPolicy.all,
    );
    final queryResult =
        await _client.query(options).timeout(kGraphQLTimeoutDuration);
    if (queryResult.hasException) {
      throw queryResult.exception;
    }
    final dataItems =
        (queryResult.data['units'] as List).cast<Map<String, dynamic>>();
    // out(queryResult.data['units']);
    final items = <UnitModel>[];
    for (final dataItem in dataItems) {
      items.add(UnitModel.fromJson(dataItem));
    }
    return items;
  }

  Future<List<CategoryModel>> readCategories() async {
    return [];
  }
}

GraphQLClient _getClient() {
  final httpLink = HttpLink(
    uri: 'https://cats-book.herokuapp.com/v1/graphql',
  );
  final authLink = AuthLink(
    getToken: () async => '',
    // getToken: () async => 'Bearer $kDatabaseToken', // TODO: getToken
  );
  var link = authLink.concat(httpLink);
  if (_kEnableWebsockets) {
    final websocketLink = WebSocketLink(
      url: 'wss://cats-book.herokuapp.com/v1/graphql',
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: const Duration(seconds: 15),
        initPayload: () async {
          out('initPayload');
          return {
            // 'headers': {'Authorization': 'Bearer $kDatabaseToken'}, // TODO: headers
          };
        },
      ),
    );
    link = link.concat(websocketLink);
  }
  return GraphQLClient(
    cache: InMemoryCache(),
    link: link,
  );
}

class _API {
  static final readUnits = gql(r'''
    query ReadUnits($category_id: category_key_enum!) {
      units(where: {breed: {category_id: {_eq: $category_id}}}) {
        id
        breed {
          ...BreedFields
        }
        color
        weight
        story
        member {
          ...MemberFields
        }
        image_url
        condition
        birthday
        address
        location
      }
    }
  ''')..definitions.addAll(fragments.definitions);

  static final fragments = gql(r'''
    fragment BreedFields on breed {
      # __typename
      id
      name
      category_id
    }
    fragment MemberFields on member {
      # __typename
      id
      name
      avatar_url
    }
  ''');
}
