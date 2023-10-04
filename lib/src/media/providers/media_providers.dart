import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:image_picker/image_picker.dart';

final uploadTaskProvider = StateProvider<UploadTask?>((ref) => null);

final selectedFileProvider = StateProvider.autoDispose<XFile?>((ref) => null);

// Delete & Edit Icons
final showMediaIconsProvider = StateProvider<bool>((ref) => false);

// Show only videos
final showOnlyVideosProvider = StateProvider<bool>((ref) => false);

