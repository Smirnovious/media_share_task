import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'description_field.dart';
import 'uploading_process.dart';
import '../../providers/media_providers.dart';
import 'media_upload_controls.dart';

class UploadBottomSheet extends ConsumerStatefulWidget {
  const UploadBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UploadBottomSheetState();
}

class _UploadBottomSheetState extends ConsumerState<UploadBottomSheet> {
  TextEditingController descriptionTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    descriptionTextController.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  final selectedFile = ref.watch(selectedFileProvider);
    return StatefulBuilder(
      builder: (BuildContext context, _) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Gap(10),
                    Row(
                      children: [
                        const Text('Upload New Media:',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          icon: const Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                    const Gap(10),
                    DescriptionField(
                        descriptionTextController: descriptionTextController),
                    const Gap(20),
                    MediaUploadControls(selectedFile: selectedFile),
                    const Gap(5),
                    if (selectedFile != null)
                      UploadingProcess(
                        formKey: formKey,
                        descriptionTextController: descriptionTextController,
                        selectedFile: selectedFile,
                      ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
