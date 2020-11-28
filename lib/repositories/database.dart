import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:cats_book/import.dart';

// ignore: uri_does_not_exist
// import '../local.dart';

const _kEnableWebsockets = false;

class DatabaseRepository {
  DatabaseRepository({GraphQLClient client}) : _client = client ?? _getClient();

  final GraphQLClient _client;

  Future<List<UnitModel>> readUnits(
      {String categoryId, String query, int limit}) async {
    assert(categoryId != null || query != null);
    assert(limit != null);
    final options = QueryOptions(
      documentNode:
          (query == null) ? _API.readUnitsByCategory : _API.readUnitsByQuery,
      variables: {
        if (categoryId != null) 'category_id': categoryId,
        if (query != null) 'query': '%$query%',
        'limit': limit,
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

  Future<List<UnitModel>> readNewestUnits({int limit}) async {
    assert(limit != null);
    final options = QueryOptions(
      documentNode: _API.readNewestUnits,
      variables: {
        'limit': limit,
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
    final items = <UnitModel>[];
    for (final dataItem in dataItems) {
      items.add(UnitModel.fromJson(dataItem));
    }
    return items;
  }

  Future<List<CategoryModel>> readCategories() async {
    final options = QueryOptions(
      documentNode: _API.readCategories,
      // variables: {},
      fetchPolicy: FetchPolicy.noCache,
      errorPolicy: ErrorPolicy.all,
    );
    final queryResult =
        await _client.query(options).timeout(kGraphQLTimeoutDuration);
    if (queryResult.hasException) {
      throw queryResult.exception;
    }
    final dataItems =
        (queryResult.data['categories'] as List).cast<Map<String, dynamic>>();
    final items = <CategoryModel>[];
    for (final dataItem in dataItems) {
      items.add(CategoryModel.fromJson(dataItem));
    }
    return items;
  }

  Future<List<BreedModel>> readBreeds() async {
    final options = QueryOptions(
      documentNode: _API.readBreeds,
      // variables: {},
      fetchPolicy: FetchPolicy.noCache,
      errorPolicy: ErrorPolicy.all,
    );
    final queryResult =
        await _client.query(options).timeout(kGraphQLTimeoutDuration);
    if (queryResult.hasException) {
      throw queryResult.exception;
    }
    final dataItems =
        (queryResult.data['breeds'] as List).cast<Map<String, dynamic>>();
    final items = <BreedModel>[];
    for (final dataItem in dataItems) {
      items.add(BreedModel.fromJson(dataItem));
    }
    return items;
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
  static final readUnitsByCategory = gql(r'''
    query ReadUnitsByCategory($category_id: String!, $limit: Int!) {
      units(
        where: 
          {breed: {category_id: {_eq: $category_id}}}, 
        order_by: {updated_at: desc},
        limit: $limit
      ) {
        ...UnitFields
      }
    }
  ''')..definitions.addAll(fragments.definitions);

  static final readUnitsByQuery = gql(r'''
    query ReadUnitsByQuery($query: String!, $category_id: String, $limit: Int!) {
      units(
        where: 
          {_and:
            [
              {_or: 
                [
                  {breed: {name: {_ilike: $query}}}, 
                  {address: {_ilike: $query}},
                ]
              },
              {breed: {category_id: {_eq: $category_id}}},
            ]
          },
        order_by: {updated_at: desc},
        limit: $limit
      ) {
        ...UnitFields
      }
    }
  ''')..definitions.addAll(fragments.definitions);

  static final readCategories = gql(r'''
    query ReadCategories {
      categories(
        order_by: {order_index: asc}
      ) {
        id
        name
        color
        total_of
        breeds(
          order_by: {name: asc}) {
          ...BreedFields
        }
      }
    }
  ''')..definitions.addAll(fragments.definitions);

  static final readNewestUnits = gql(r'''
    query ReadNewestUnits($limit: Int!) {
      units(
        order_by: {updated_at: desc},
        limit: $limit
      ) {
        ...UnitFields
      }
    }
  ''')..definitions.addAll(fragments.definitions);

  // static final readUnits = gql(r'''
  //   query ReadUnits($category_id: category_key_enum!) {
  //     units(where: {breed: {category_id: {_eq: $category_id}}}) {
  //       id
  //       breed {
  //         ...BreedFields
  //       }
  //       color
  //       weight
  //       story
  //       member {
  //         ...MemberFields
  //       }
  //       image_url
  //       condition
  //       birthday
  //       address
  //       location
  //     }
  //   }
  // ''')..definitions.addAll(fragments.definitions);

  static final readBreeds = gql(r'''
    query ReadBreeds {
      breeds(order_by: {name: asc}) {
        ...BreedFields
      }
    }
  ''')..definitions.addAll(fragments.definitions);

  static final fragments = gql(r'''
    fragment BreedFields on breed {
      # __typename
      id
      name
      # category_id
    }

    fragment MemberFields on member {
      # __typename
      id
      display_name
      image_url
    }

    fragment UnitFields on unit {
      # __typename
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
  ''');
}
