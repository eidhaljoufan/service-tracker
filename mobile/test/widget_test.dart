import 'package:flutter_test/flutter_test.dart';

import 'package:plaza_mini_service_tracker/main.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ServiceTrackerApp());
    expect(find.text('PLAZA MINI SERPONG'), findsOneWidget);
    expect(find.text('Lacak Status'), findsOneWidget);
  });
}
