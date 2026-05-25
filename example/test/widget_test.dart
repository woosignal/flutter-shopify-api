import 'package:flutter_test/flutter_test.dart';
import 'package:woosignal_shopify_example/endpoints.dart';
import 'package:woosignal_shopify_example/main.dart';

void main() {
  testWidgets('Explorer renders without an app key', (tester) async {
    await tester.pumpWidget(const ExampleApp());

    expect(find.text('Shopify API Explorer'), findsOneWidget);
    expect(find.textContaining('WOOSIGNAL_KEY'), findsOneWidget);
    expect(find.text('Catalog'), findsOneWidget);
    expect(find.text('getProducts'), findsOneWidget);
  });

  test('Endpoint registry is well-formed', () {
    expect(kEndpoints, isNotEmpty);
    final keys = <String>{};
    for (final e in kEndpoints) {
      expect(e.title, isNotEmpty);
      expect(e.group, isNotEmpty);
      expect(keys.add('${e.group}/${e.title}'), isTrue,
          reason: 'duplicate ${e.group}/${e.title}');
      final inputKeys = <String>{};
      for (final input in e.inputs) {
        expect(inputKeys.add(input.key), isTrue,
            reason: 'duplicate input key ${input.key} in ${e.title}');
      }
    }
  });
}
