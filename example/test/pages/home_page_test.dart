import 'package:example/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  group('HomePage', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        const HomePage(),
      );

      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(EditorPage), findsOneWidget);
    });
  });
}
