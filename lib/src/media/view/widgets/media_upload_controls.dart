import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/media_repository.dart';

class MediaUploadControls extends ConsumerWidget {
  const MediaUploadControls({
    super.key,
    required this.selectedFile,
  });

  final XFile? selectedFile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        selectedFile != null
            ? SizedBox(
                height: 200,
                width: 200,
                child: selectedFile!.path.endsWith('.mp4')
                    ? const Text('No Video Preview')
                    : Image.file(File(selectedFile!.path)))
            : const Text('No File Selected'),
      ],
    );
  }
}
