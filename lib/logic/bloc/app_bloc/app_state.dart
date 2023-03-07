// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

@immutable
class AppState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;
  const AppState({
    required this.isLoading,
    this.data,
    this.error,
  });

  const AppState.empty()
      : this(
          isLoading: false,
          data: null,
          error: null,
        );

  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error,
      }.toString();

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        (data ?? []).isEqual((other.data ?? [])) &&
        other.error == error;
  }

  @override
  int get hashCode => isLoading.hashCode ^ data.hashCode ^ error.hashCode;
}

extension Comparison<E> on List<E> {
  bool isEqual(List<E> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
