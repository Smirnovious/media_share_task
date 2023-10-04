import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:media_share_task/src/media/view/widgets/filter_chips.dart';
import 'package:media_share_task/src/media/view/widgets/safe_exit.dart';
import '../../auth/providers/auth_providers.dart';
import '../../common/main_app_bar.dart';
import '../../shared_pref.dart';
import '../providers/media_providers.dart';
import 'widgets/media_feed.dart';
import 'widgets/upload_bottom_sheet.dart';

class MediaScreen extends ConsumerStatefulWidget {
  const MediaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MediaScreenState();
}

class _MediaScreenState extends ConsumerState<MediaScreen> {
  @override
  void initState() {
    super.initState();
    SharedPref.getUsername().then((value) {
      ref.read(usernameProvider.notifier).state = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(showOnlyVideosProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MainAppBar(logOutVisible: true),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: SharedPref.getUsername(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Welcome ${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const Text('Welcome');
                  }
                },
              ),
              const Gap(10),
              const FilterChips(),
              const Gap(20),
              const MediaFeed(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return const SafeExit(child: UploadBottomSheet(),);
                });
          },
          child: const Icon(Icons.cloud_upload),
        ));
  }
}

