import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final uploadTaskProvider = StateProvider<UploadTask?>((ref) => null);

final selectedFileProvider = StateProvider.autoDispose<XFile?>((ref) => null);

// Delete & Edit Icons
final showMediaIconsProvider = StateProvider<bool>((ref) => false);

// Show only videos
final showOnlyVideosProvider = StateProvider<bool>((ref) => false);

final getVideoThumbnail = Provider<Future>((ref) {
  return VideoThumbnail.thumbnailData(
    video: ref.read(selectedFileProvider)!.path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 150,
    maxHeight: 150,
    quality: 100,
  );
});
