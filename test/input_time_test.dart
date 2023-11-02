import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_time.dart';

void main() {
  testWidgets('TimeInput UI test', (WidgetTester tester) async {
    final timeController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TimeInput(timeController: timeController),
        ),
      ),
    );

    // Memeriksa apakah TextFormField muncul.
    expect(find.byType(TextFormField), findsOneWidget);

    // Memeriksa apakah ikon waktu (clock) muncul.
    expect(find.byIcon(Iconsax.clock), findsOneWidget);

    // Menekan ikon waktu (clock).
    await tester.tap(find.byIcon(Iconsax.clock));
    await tester.pumpAndSettle();

    // Menekan jam pada time picker.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Memeriksa teks yang diinput pada TextFormField.
    expect(timeController.text.isNotEmpty, true);
  });
}
