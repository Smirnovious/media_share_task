import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../providers/media_providers.dart';

class FilterChips extends ConsumerWidget {
  const FilterChips({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(showOnlyVideosProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterChip(
            label: const Text('Images'),
            selected: !ref.read(showOnlyVideosProvider),
            onSelected: (value) {
              ref.read(showOnlyVideosProvider.notifier).state = false;
            }),
        const Gap(10),
        FilterChip(
            label: const Text('Videos'),
            selected: ref.read(showOnlyVideosProvider),
            onSelected: (value) {
              ref.read(showOnlyVideosProvider.notifier).state = true;
            }),
      ],
    );
  }
}
