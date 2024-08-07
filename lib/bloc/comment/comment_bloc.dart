import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_http/models/comment_model.dart';
import 'package:flutter_http/repoistory/comments_repostiory.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  late CommentsRepository commentsRepository;
  CommentsBloc() : super(CommentsLoadingState()) {
    commentsRepository = CommentsRepository();
    on<CommentsFetchEvent>(_onGetComments);
  }

  FutureOr<void> _onGetComments(
      CommentsFetchEvent event, Emitter<CommentsState> emit) async {
    emit(CommentsLoadingState());
    var callResult = await commentsRepository.get({'postId': event.postId});
    if (callResult.isSuscces) {
      var comments = List<Comment>.from(
          callResult.data.map((e) => Comment.fromJson(e)).toList());
      emit(CommentsLoadedState(comments));
    } else {
      emit(CommentsErrorState(callResult.error));
    }
  }
}
