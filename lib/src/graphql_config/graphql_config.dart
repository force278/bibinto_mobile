import 'package:bibinto/src/common/domain/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  LocalStorage localStorage = LocalStorage();

  HttpLink get httpLinkWithToken {
    return HttpLink(
      'https://api.bibinto.com/',
      defaultHeaders: {
        if (localStorage.appToken != null) 'token': '${localStorage.appToken}',
      },
    );
  }

  WebSocketLink get websocketLink {
    return WebSocketLink(
      'wss://ws.bibinto.com',
      subProtocol: GraphQLProtocol.graphqlTransportWs,
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: const Duration(seconds: 30),
        initialPayload: {
          'token': localStorage.appToken ?? '',
        },
      ),
    );
  }

  Link get link {
    return Link.split(
      (request) => request.isSubscription,
      websocketLink,
      httpLinkWithToken,
    );
  }

  ValueNotifier<GraphQLClient> get clientToQuery {
    final GraphQLCache cache = GraphQLCache();
    return ValueNotifier(
      GraphQLClient(
        link: link,
        cache: cache,
      ),
    );
  }
}
