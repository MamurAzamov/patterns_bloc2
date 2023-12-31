import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patterns_bloc2/bloc/create_bloc.dart';
import 'package:patterns_bloc2/bloc/home_event.dart';
import 'package:patterns_bloc2/bloc/home_state.dart';
import 'package:patterns_bloc2/services/http_service.dart';

import '../model/post_model.dart';
import '../pages/create_page.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<DeletePostEvent>(_onDeletePost);
  }

  void callCreatePage(BuildContext context) async {
    var results = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => CreateBloc(),
              child: const CreatePage(),
            )));
    if (results != null) {
      add(LoadPostsEvent());
    }
  }
}

Future<void> _onLoadPosts(LoadPostsEvent event, Emitter<HomeState> emit) async {
  emit(HomeLoadingState());
  final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
  if (response != null) {
    final posts = Network.parsePostList(response);
    emit(HomePostListState(posts));
  } else {
    emit(HomeErrorState("Could'nt fetch posts"));
  }
}

Future<void> _onDeletePost(
    DeletePostEvent event, Emitter<HomeState> emit) async {
  emit(HomeLoadingState());
  final response = await Network.DEL(Network.API_DELETE, Network.paramsEmpty());
  if (response != null) {
    emit(HomeDeletePostState());
  } else {
    emit(HomeErrorState("Could'nt delete posts"));
  }

  void callUpdatePage(BuildContext context, Post post) async {
    // print(post.toJson());
    // await Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => UpdatePage(post: post)));
  }
}
