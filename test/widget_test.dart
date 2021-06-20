// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:retroshare/main.dart';

import 'package:retroshare/redux/store.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    String locationId = "814228577bc0c5da968c79272adcbfce";
//    String password = "prueba";
//    openapi = DefaultApi();
//    initializeAuth(locationId, password);

    // Build our app and trigger a frame.
    final identityStore = await retroshareStore();
    await tester.pumpWidget(App(identityStore));
  });
}
