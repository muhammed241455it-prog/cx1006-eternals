import 'package:flutter_test/flutter_test.dart';

import 'package:cx1006_eternals/main.dart';

void main() {
  testWidgets('CX1006 app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const Cx1006App());

    expect(find.text('The Disability the App Forgot'), findsOneWidget);
    expect(find.text('View Broken Form'), findsOneWidget);
    expect(find.text('View Remediated Form'), findsOneWidget);
  });
}