import 'lib/widgets/blog_row.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

//...
final HttpLink httpLink = HttpLink("YOUR_HYGRAPH_API");

final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);

const String updatePostMutation = """
mutation {
  updatePost(
    where: { id: "ckadrcx4g00pw01525c5d2e56" }
    data: { author: "Elijah Asaolu" }
  ) {
    id
    name
    price
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
                  "Hypgraph Blog",
                ),
              ),
              body: Mutation(
                options: MutationOptions(
                  document: gql(updatePostMutation),
                ),
                builder: (runMutation, result) {
                  return TextButton(
                    onPressed: () {
                      final result = runMutation({});
                      // Do something with result
                    },
                    child: const Text('Create Todo'),
                  );
                },
              ))),
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
