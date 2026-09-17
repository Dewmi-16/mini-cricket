import 'package:flutter_test/flutter_test.dart';
import 'package:mini_cricket/main.dart';

void main() {
  testWidgets('Mini Cricket starts with zero runs and six balls',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MiniCricketApp());

    expect(find.text('Mini Cricket'), findsOneWidget);
    expect(find.text('Runs'), findsOneWidget);
    expect(find.text('Balls'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('Bat'), findsOneWidget);
  });

  testWidgets('Pressing Bat removes one ball', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniCricketApp());

    await tester.tap(find.text('Bat'));
    await tester.pump();

    expect(find.text('5'), findsOneWidget);
  });
}
