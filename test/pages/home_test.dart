import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_timer/pages/home.dart';
import 'package:workout_timer/pages/workout_setting.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Title displays', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp());

    expect(find.text('Workout Timer'), findsOneWidget);
  });

  group('Home page navigation', () {
    const navigateToWorkoutSettingButtonKey = Key('navigateToWorkoutSetting');
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Home(title: 'Workout Timer'),

        navigatorObservers: [mockObserver],
      ));

      verify(mockObserver.didPush(any, any));
    }

    Future<void> _navigateToWSPage(WidgetTester tester) async {
      await tester.tap(find.byKey(navigateToWorkoutSettingButtonKey));
      await tester.pumpAndSettle();
    }

    // Future<void> _navigateToWSPageFromPreset(WidgetTester tester) async {
    //   await tester.tap(find.byWidget(GestureDetector()));
    //   await tester.pumpAndSettle();
    // };

    testWidgets('New Workout button displays', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp());

      expect(find.byKey(navigateToWorkoutSettingButtonKey), findsOneWidget);
    });
    
    testWidgets(
        'when tapping the "New Workout" button, should navigate to workout settings page', 
        (WidgetTester tester) async {
      await _buildMainPage(tester);
      await _navigateToWSPage(tester);
      verify(mockObserver.didPush(any, any));

      expect(find.byType(WorkoutSetting), findsOneWidget);
    });
    
    // testWidgets(
    //     'when tapping a preset, it should navigate to workout settings page', 
    //     (WidgetTester tester) async {
    //   await _buildMainPage(tester);
    //   await _navigateToWSPageFromPreset(tester);
    //   verify(mockObserver.didPush(any, any));

    //   expect(find.byType(WorkoutSetting), findsOneWidget);
    // });
  });
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(title: 'Workout Timer'),);
  }
}
