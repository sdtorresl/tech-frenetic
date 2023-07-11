import 'package:techfrenetic/app/modules/vendors/vendor_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

main() {
  group('VendorPage', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(const VendorPage(vendor: 'T')));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}
