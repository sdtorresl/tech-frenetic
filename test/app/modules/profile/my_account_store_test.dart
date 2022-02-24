import 'package:flutter_test/flutter_test.dart';
import 'package:techfrenetic/app/modules/profile/my_account_store.dart';
 
void main() {
  late MyAccountStore store;

  setUpAll(() {
    store = MyAccountStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}