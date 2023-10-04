import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../api/media_repository.dart';
import 'media_item.dart';

class EditAndDelIcons extends ConsumerWidget {
  const EditAndDelIcons({
    super.key,
    required this.mediaItem,
    
  });

  final MediaItem mediaItem;
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                ref.read(mediaRepositoryProvider).deleteMediaFromFirestore(
                    mediaItem.snapshot.data!.docs[mediaItem.index], context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
          const Gap(10),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                context.go('/editMedia', extra: [
                  mediaItem.snapshot.data!.docs[mediaItem.index]['downloadUrl'],
                  mediaItem.snapshot.data!.docs[mediaItem.index]['fileName'],
                  

                ]);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
