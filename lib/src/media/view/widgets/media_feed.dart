import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:media_share_task/src/media/view/widgets/media_item.dart';

import '../../api/media_repository.dart';
import '../../providers/media_providers.dart';

class MediaFeed extends ConsumerStatefulWidget {
  const MediaFeed({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MediaFeedState();
}

class _MediaFeedState extends ConsumerState<MediaFeed> {
  @override
  Widget build(BuildContext context) {
    ref.watch(showOnlyVideosProvider);
    return StreamBuilder<QuerySnapshot>(
      stream: ref.read(mediaRepositoryProvider).mediaAsStream(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Center(child: Text('Something went wrong')),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No Media yet. Upload Something!'),
          );
        } else if (snapshot.hasData) {
          return Expanded(
            child: MasonryGridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return MediaItem(index: index, snapshot: snapshot,
                key: ValueKey(snapshot.data!.docs[index].id)
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text('No data found'),
          );
        }
      },
    );
  }
}
