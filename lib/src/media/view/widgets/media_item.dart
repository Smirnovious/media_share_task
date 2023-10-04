import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_share_task/src/shared_pref.dart';
import 'package:video_player/video_player.dart';
import '../../providers/media_providers.dart';
import 'edit_and_delete_icons.dart';
import 'image_card.dart';
import 'video_card.dart';

class MediaItem extends ConsumerStatefulWidget {
  const MediaItem({
    Key? key,
    required this.index,
    required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot snapshot;
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MediaItemState();
}

class _MediaItemState extends ConsumerState<MediaItem> {
  var description = '';
  @override
  void initState() {
    super.initState();
    SharedPref.getMediaDescription(
            widget.snapshot.data!.docs[widget.index]['fileName'])
        .then((value) {
      setState(() {
        description = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final showIcons = ref.watch(showMediaIconsProvider);

    return GestureDetector(
      onDoubleTap: () {
        ref.read(showMediaIconsProvider.notifier).state = !showIcons;
      },
      child: Stack(
        children: [
          Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: widget.snapshot.data!.docs[widget.index]['fileName']
                      .toString()
                      .contains('mp4')
                  ? VideoCard(
                      videoPlayerController: VideoPlayerController.networkUrl(
                          Uri.parse(widget.snapshot.data!.docs[widget.index]
                              ['downloadUrl'])))
                  : ImageCard(snapshot: widget.snapshot, index: widget.index)),
          showIcons ? EditAndDelIcons(mediaItem: widget) : const SizedBox(),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              // width: 100,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              // width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                description,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
