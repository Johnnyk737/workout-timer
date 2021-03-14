import 'package:flutter_test/flutter_test.dart';
import 'package:workout_timer/main.dart';

void main() {
  testWidgets('Title displays', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Workout Timer'), findsOneWidget);
  });
}
