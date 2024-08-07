part of 'comment_bloc.dart';

@immutable
sealed class CommentsState {}

final class CommentsLoadingState extends CommentsState {}

final class CommentsLoadedState extends CommentsState {
  final List<Comment> comments;
  CommentsLoadedState(this.comments);
}

final class CommentsErrorState extends CommentsState {
  final String error;
  CommentsErrorState(this.error);
}
