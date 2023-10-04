import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../api/media_repository.dart';
import '../../providers/media_providers.dart';

class MediaUploadControls extends ConsumerStatefulWidget {
  const MediaUploadControls({
    super.key,
    required this.selectedFile,
  });

  final XFile? selectedFile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MediaUploadControlsState();
}

class _MediaUploadControlsState extends ConsumerState<MediaUploadControls> {
  // Future getThumbnail() async {
  //   final uint8list = await VideoThumbnail.thumbnailData(
  //     video: widget.selectedFile!.path,
  //     imageFormat: ImageFormat.JPEG,
  //     maxWidth: 150,
  //     maxHeight: 150,
  //     quality: 100,
  //   );
  //   return uint8list;
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref
                    .read(mediaRepositoryProvider)
                    .selectVideoFileToUpload(ref, context);
              },
              child: const Text('Select Video'),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(mediaRepositoryProvider)
                    .selectImageFileToUpload(ref, context);
              },
              child: const Text('Select Image'),
            ),
          ],
        ),
        const Gap(10),
        widget.selectedFile != null
            ? SizedBox(
                height: 200,
                width: 200,
                child: widget.selectedFile!.path.endsWith('.mp4')
                    ? FutureBuilder(
                        future: ref.read(getVideoThumbnail),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Column(
                              children: [
                                const Text('Video Thumbnail:'),
                                Image.memory(snapshot.data as Uint8List),
                              ],
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        })
                    : Image.file(File(widget.selectedFile!.path)))
            : const Text('No File Selected'),
      ],
    );
  }
}
