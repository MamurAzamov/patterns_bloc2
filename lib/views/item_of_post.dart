import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patterns_bloc2/bloc/home_bloc.dart';

import '../model/post_model.dart';
import '../pages/album_page.dart';
import '../pages/comment_page.dart';

Widget itemOfPost(BuildContext context, HomeBloc homeBloc, Post post) {
  return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlbumPage()));
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.photo_library,
            label: "Photos",
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommentPage()));
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.comment,
            label: "Comment",
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(post.title.toUpperCase()),
            const SizedBox(
              height: 5,
            ),
            Text(post.body),
          ],
        ),
      ));
}
