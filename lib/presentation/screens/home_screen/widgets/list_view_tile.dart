import 'package:flutter/material.dart';

extension ToListView<T> on Iterable<T> {
  Widget toListView() => ListViewTile(iterable: this);
}

class ListViewTile<T> extends StatelessWidget {
  final Iterable<T> iterable;
  const ListViewTile({Key? key, required this.iterable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: iterable.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(iterable.elementAt(index).toString()),
        );
      },
    );
  }
}
