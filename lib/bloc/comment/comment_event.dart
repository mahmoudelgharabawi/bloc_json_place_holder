part of 'comment_bloc.dart';

@immutable
sealed class CommentsEvent {}

class CommentsFetchEvent extends CommentsEvent {
  final int postId;
  CommentsFetchEvent(this.postId);
}
