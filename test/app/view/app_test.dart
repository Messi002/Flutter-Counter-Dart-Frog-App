import 'package:counterdartfrog/app/view/app.dart';
import 'package:counterdartfrog/counter/view/counter_page.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.runAsync(() => tester.pumpWidget(const App()));
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
