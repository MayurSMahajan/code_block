import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:example/pages/editor_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  group('EditorPage', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        const EditorPage(),
      );

      await tester.pumpAndSettle();

      expect(find.byType(EditorPage), findsOneWidget);
      expect(find.byType(AppFlowyEditor), findsOneWidget);
    });
  });
}
