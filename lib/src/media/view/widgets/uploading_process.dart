import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared_pref.dart';
import '../../api/media_repository.dart';
import '../../providers/media_providers.dart';

class UploadingProcess extends ConsumerStatefulWidget {
  const UploadingProcess(
      {super.key,
      required this.formKey,
      required this.descriptionTextController,
      required this.selectedFile});
  final GlobalKey<FormState> formKey;
  final TextEditingController descriptionTextController;
  final XFile? selectedFile;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UploadingProcessState();
}

class _UploadingProcessState extends ConsumerState<UploadingProcess> {
  @override
  Widget build(BuildContext context) {
    final uploadTask = ref.watch(uploadTaskProvider);
    return StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap!.bytesTransferred / snap.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(progress * 100).toStringAsFixed(2)}%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  SharedPref.setMediaDescription(
                      description: widget.descriptionTextController.text,
                      fileName: widget.selectedFile!.name);

                  // Method of Uploading
                  ref.read(mediaRepositoryProvider).uploadFile(ref, context);
                }
              },
              child: const Text('Upload'),
            );
          }
        });
  }
}
