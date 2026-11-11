import 'package:campusly/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Campusly screen renders', (tester) async {
    await tester.pumpWidget(const CampuslyApp());

    expect(find.text('Campusly'), findsOneWidget);
  });
}
