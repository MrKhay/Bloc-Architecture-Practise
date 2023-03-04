// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_practise/presentation/common_widgets/dialogs/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({required BuildContext context, required String text}) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(context: context, text: text);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController _showOverlay(
      {required BuildContext context, required String text}) {
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overLay = OverlayEntry(builder: (context) {
      return Material(
        /// the color that would cove the whole screen
        color: Colors.black.withAlpha(150),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20.0),
                    StreamBuilder<String>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                      stream: _text.stream,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    state.insert(overLay);

    return LoadingScreenController(close: () {
      _text.close();
      overLay.remove();
      return true;
    }, update: (text) {
      _text.add(text);
      return true;
    });
  }
}
