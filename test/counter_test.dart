import 'package:flutter_test/flutter_test.dart';
import 'package:myproject/counter.dart';

void main() {
  test('测试递增', () {
    final counter = Counter();
    counter.increment();

    expect(counter.value, 1);
  });

  group('Counter', () {
    test('start-->0', () {
      expect(Counter().value, 0);
    });
    test('add', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
    test('decrease', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });
  });
}
