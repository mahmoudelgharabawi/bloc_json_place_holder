import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http/bloc/comment/comment_bloc.dart';
import 'package:flutter_http/models/post_model.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;
  const PostDetailsPage({required this.post, super.key});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  bool isExpand = false;
  @override
  void initState() {
    init();

    super.initState();
  }

  void init() async {
    context.read<CommentsBloc>().add(CommentsFetchEvent(widget.post.id!));
    if (isExpand) {
      isExpand = false;
      setState(() {});
    }
    await Future.delayed(const Duration(milliseconds: 300));
    isExpand = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.id.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // post header
            AnimatedContainer(
              height: isExpand ? 180 : 0,
              duration: const Duration(milliseconds: 400),
              child: SingleChildScrollView(
                child: PhysicalModel(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(15),
                    shadowColor: Colors.black,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.title ?? 'No Title',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(widget.post.body ?? 'No Body',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(width: 5),
                              Text(widget.post.userId.toString())
                            ],
                          )

                          // post details
                        ],
                      ),
                    )),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Comments:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),

            // comments
            Expanded(child:
                BlocBuilder<CommentsBloc, CommentsState>(builder: (ctx, state) {
              if (state is CommentsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CommentsErrorState) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is CommentsLoadedState) {
                return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        surfaceTintColor: Colors.black12,
                        child: ListTile(
                          title: Text(state.comments[index].body ?? 'No body'),
                          subtitle:
                              Text(state.comments[index].email ?? 'No Email'),
                        ),
                      );
                    });
              }
              return const Text('No State Detected');
            }))
          ],
        ),
      ),
    );
  }
}
