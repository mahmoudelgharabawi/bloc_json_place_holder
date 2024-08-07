import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http/bloc/post/posts_bloc.dart';
import 'package:flutter_http/pages/post_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PostsBloc>().add(PostsFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: BlocBuilder<PostsBloc, PostsState>(builder: (ctx, state) {
          if (state is PostsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostsErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is PostsLoadedState) {
            return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    surfaceTintColor: Colors.black12,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PostDetailsPage(post: state.posts[index]);
                          },
                        ));
                      },
                      title: Text(state.posts[index].title ?? 'No Title'),
                      subtitle: Text(state.posts[index].body ?? 'No BODY'),
                    ),
                  );
                });
          }
          return const Text('No State Detected');
        }));
  }
}
