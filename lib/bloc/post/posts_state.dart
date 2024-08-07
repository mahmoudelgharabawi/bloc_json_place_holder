part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsLoadingState extends PostsState {}

final class PostsLoadedState extends PostsState {
  final List<Post> posts;
  PostsLoadedState(this.posts);
}

final class PostsErrorState extends PostsState {
  final String error;
  PostsErrorState(this.error);
}
