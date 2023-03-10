// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/popup_widget/popup_menu.dart';
import 'package:flutter_bloc_practise/presentation/screens/storage_image_screen/storage_image_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/strings.dart';
import '../../../logic/bloc/app_bloc/app_bloc.dart';

class GalleryScreen extends HookWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<AppBloc>().state.images ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.photoGallery),
        actions: [
          /// upload appbar [BUTTON]
          IconButton(
              onPressed: () async {
                final image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image == null) {
                  return;
                } else {
                  context.read<AppBloc>().add(AppEventUploadImage(
                        filePathToUpload: image.path,
                      ));
                }
              },
              icon: const Icon(Icons.upload)),

          /// popup appbar [BUTTON]
          const PopupMenu()
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8.0),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: images.map((img) => StorageImageScreen(image: img)).toList(),
      ),
    );
  }
}
