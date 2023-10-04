import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/media_providers.dart';

class VideoThumbnail extends ConsumerStatefulWidget {
  const VideoThumbnail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends ConsumerState<VideoThumbnail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ref.read(getVideoThumbnail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                const Text('Video Thumbnail:'),
                Image.memory(snapshot.data as Uint8List),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
