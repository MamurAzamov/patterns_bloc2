import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patterns_bloc2/bloc/home_bloc.dart';
import 'package:patterns_bloc2/pages/album_page.dart';
import 'package:patterns_bloc2/pages/comment_page.dart';
import 'package:patterns_bloc2/pages/home_page.dart';

import 'bloc/album_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PhotoRepository repository = PhotoRepository();
  final PhotoBloc bloc = PhotoBloc(PhotoRepository());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => bloc..fetchPhotos(),
          child: AlbumPage(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => HomeBloc(),
          child: const HomePage(),
        ),
        routes: {
          CommentPage.id: (context) => CommentPage(),
          AlbumPage.id: (context) => AlbumPage()
        },
      ),
    );
  }
}
