import 'package:flutter_test/flutter_test.dart';
import 'package:workout_timer/main.dart';

void main() {
  testWidgets('New Workout button displays', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Workout Timer'), findsOneWidget);
  });
}
