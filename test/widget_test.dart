import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokepedia/main.dart';

void main() {
  testWidgets('Pokepedia App renders correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(PokepediaApp());

    // Verify that the app shows the AppBar with title 'Pokepedia'.
    expect(find.text('Pokepedia'), findsOneWidget);

    // Verify that there is a GridView widget present.
    expect(find.byType(GridView), findsOneWidget);

    // Verify that there is a CircularProgressIndicator widget present when data is loading.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // You can further expand this to test the actual content once the data is loaded.
  });
}
