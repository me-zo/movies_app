extension Listing<E> on List<E> {
  List<T> mapList<T>(T Function(E e) toElement) => map(toElement).toList();
}
