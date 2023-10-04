import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_share_task/src/common/error_dialog.dart';
import 'package:media_share_task/src/media/providers/media_providers.dart';
import 'dart:isolate';

class MediaRepository {
  final storageClient = FirebaseStorage.instance;

  // Stream of Media
  Stream<QuerySnapshot> mediaAsStream(ref) {
    return FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .where('isVideo', isEqualTo: ref.read(showOnlyVideosProvider))
        .snapshots();
  }

  // Select Video
  Future<void> selectVideoFileToUpload(ref, context) async {
    try {
      XFile? pickedVideo =
          await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        ref.read(selectedFileProvider.notifier).state = pickedVideo;
      }
    } catch (e) {
      showDialog(context: context, builder: (context) => ErrorDialog(e: e));
    }
  }

  // Select Image
  Future<void> selectImageFileToUpload(ref, context) async {
    try {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        ref.read(selectedFileProvider.notifier).state = pickedImage;
      }
    } catch (e) {
      showDialog(context: context, builder: (context) => ErrorDialog(e: e));
    }
  }

  // Delete Media
  Future<void> deleteMediaFromFirestore(doc, context) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(doc.id)
          .delete();
      await storageClient.refFromURL(doc['downloadUrl']).delete();
    } catch (e) {
      showDialog(context: context, builder: (context) => ErrorDialog(e: e));
    }
  }

  // Upload File 
  void uploadFile(ref, context) async {
    final selectedFile = ref.watch(selectedFileProvider);
    final user = FirebaseAuth.instance.currentUser;
    final userCollection = FirebaseFirestore.instance.collection('users');
    final userId = userCollection.doc(user!.uid);
    try {
      // Define path that includes userId
      final path = 'files/${userId.id}/${selectedFile!.name}';
      // Creating a reference to the file to upload
      final firebaseReference = FirebaseStorage.instance.ref().child(path);
      // Upload the file to Firebase Storage
      ref.read(uploadTaskProvider.notifier).state = firebaseReference.putFile(
        File(selectedFile.path!),
      );
     
      // Do something when the upload task is complete
      await ref.read(uploadTaskProvider.notifier).state!.whenComplete(() async {
        // Get The Download Url
        final url = await firebaseReference.getDownloadURL();

        // Save the file metadata to Firestore
        saveFileMetadataToFirestore(
          id: path,
          userId: userId.id,
          fileName: selectedFile.name,
          downloadUrl: url.toString(),
          isVideo: selectedFile.name.endsWith('.mp4') ||
              selectedFile.name.endsWith('.mov'),
        );
        // Close The Bottom Sheet
        GoRouter.of(context).pop();
      });
    } catch (e) {
      showDialog(context: context, builder: (context) => ErrorDialog(e: e));
    }
  }

  // Save the file metadata to Firestore
  Future<void> saveFileMetadataToFirestore({
    required String userId,
    required String id,
    required String fileName,
    required String downloadUrl,
    required bool isVideo,
  }) async {
    await FirebaseFirestore.instance.collection(userId).add({
      'ID': id,
      'fileName': fileName,
      'downloadUrl': downloadUrl,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'isVideo': fileName.endsWith('.mp4') || fileName.endsWith('.mov'),
    });
  }
}

// Instance of MediaRepository
final mediaRepositoryProvider =
    Provider<MediaRepository>((ref) => MediaRepository());
