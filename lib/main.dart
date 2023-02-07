import 'widgets/blog_row.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

//...
final HttpLink httpLink = HttpLink(
    "https://api-us-east-1-shared-usea1-02.hygraph.com/v2/cldf0bjvr1rv801un61efbrpm/master");

final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);

const String query = """
query Content{
  posts{
    id
    publishedAt
    title
    excerpt
    coverImage {
      url
    }
  }
}
""";
// ...

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          title: 'GraphQL Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Hygraph Blog",
              ),
            ),
            body: Query(
                options: QueryOptions(
                    document: gql(query),
                    variables: const <String, dynamic>{"code": "AF"}),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (result.data == null) {
                    return const Center(
                      child: Text("No article found!"),
                    );
                  }
                  final posts = result.data!['posts'];
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final title = post['title'];
                      final excerpt = post['excerpt'];
                      final coverImageURL = post!['coverImage']['url'];
                      return BlogRow(
                        title: title,
                        excerpt: excerpt,
                        coverURL: coverImageURL,
                      );
                    },
                  );
                }),
          )),
    );

    // MaterialApp(
    //   title: 'Hello World',
    //   theme: ThemeData.light(),
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(
    //         "Hypgraph Blog",
    //       ),
    //     ),
    //     body: ListView(
    //       children: const [
    //         BlogRow(
    //           title: 'Blog 1',
    //           excerpt: 'Blog 1 excerpt',
    //           coverURL: 'https://picsum.photos/300',
    //         ),
    //         BlogRow(
    //           title: 'Blog 2',
    //           excerpt: 'Blog 2 excerpt',
    //           coverURL: 'https://picsum.photos/300',
    //         ),
    //         BlogRow(
    //           title: 'Blog 3',
    //           excerpt: 'Blog 3 excerpt',
    //           coverURL: 'https://picsum.photos/300',
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
