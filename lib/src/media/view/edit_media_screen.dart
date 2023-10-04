import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../shared_pref.dart';

class EditMediaScreen extends ConsumerStatefulWidget {
  const EditMediaScreen({super.key, required this.args});
  final List args;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditMediaScreenState();
}

class _EditMediaScreenState extends ConsumerState<EditMediaScreen> {
  final TextEditingController _newDescriptionTextController =
      TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Media'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: CachedNetworkImage(imageUrl: widget.args[0])),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _newDescriptionTextController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'New Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await SharedPref.setMediaDescription(
                      description: _newDescriptionTextController.text,
                      fileName: widget.args[1]);
                  mounted ? context.go('/') : null;
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
