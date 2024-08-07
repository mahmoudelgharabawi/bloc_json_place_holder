import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_http/models/post_model.dart';
import 'package:flutter_http/repoistory/posts_repostiory.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  late PostsRepository postsRepository;
  PostsBloc() : super(PostsLoadingState()) {
    postsRepository = PostsRepository();
    on<PostsEvent>(_onGetPosts);
  }

  FutureOr<void> _onGetPosts(PostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    var callResult = await postsRepository.get();
    if (callResult.isSuscces) {
      var posts = List<Post>.from(
          callResult.data.map((e) => Post.fromJson(e)).toList());
      emit(PostsLoadedState(posts));
    } else {
      emit(PostsErrorState(callResult.error));
    }
  }
}
