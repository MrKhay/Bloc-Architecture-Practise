import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StorageImageScreen extends StatelessWidget {
  const StorageImageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);
  final Reference image;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: image.getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox();
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.active:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            if (snapshot.hasData) {
              final data = snapshot.data;
              return Image.memory(
                data!,
                fit: BoxFit.cover,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
        }
      },
    );
  }
}
