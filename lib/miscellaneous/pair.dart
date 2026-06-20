final class Pair<T1, T2> {
  const Pair(this.first, this.second);

  final T1 first;
  final T2 second;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Pair<T1, T2> && first == other.first && second == other.second;

  @override
  int get hashCode => Object.hash(first, second);

  @override
  String toString() => 'Pair($first, $second)';
}
