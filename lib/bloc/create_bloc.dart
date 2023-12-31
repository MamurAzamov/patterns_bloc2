import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:patterns_bloc2/bloc/create_event.dart';
import 'package:patterns_bloc2/bloc/create_state.dart';
import 'package:patterns_bloc2/services/http_service.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitialState()) {
    on<CreatePostEvent>(_onCreatePost);
  }

  Future<void> _onCreatePost(
      CreatePostEvent event, Emitter<CreateState> emit) async {
    emit(CreateLoadingState());
    final response = await Network.POST(
        Network.API_CREATE, Network.paramsCreate(event.post));
    if (response != null) {
      final posts = Network.parsePostList(response);
      emit(CreatedPostListState(posts));
    } else {
      emit(CreateErrorState("Could'nt create posts"));
    }
  }
}
