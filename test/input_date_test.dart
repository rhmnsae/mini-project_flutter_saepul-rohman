import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_date.dart';

void main() {
  testWidgets('DateInput UI Test', (WidgetTester tester) async {
    final dateController = TextEditingController();

    // Build the DateInput widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DateInput(dateController: dateController),
        ),
      ),
    );

    // Temukan TextFormField untuk memvalidasi
    expect(find.byType(TextFormField), findsOneWidget);

    // Masukkan tanggal
    await tester.enterText(find.byType(TextFormField), '12-05-2023');

    // Memverifikasi apakah TextFormField ada
    expect(find.byType(TextFormField), findsOneWidget);

    // Mengetuk ikon kalender di bagian belakang TextFormField
    await tester.tap(find.byIcon(Iconsax.calendar_1));
    await tester.pumpAndSettle();

    // Memverifikasi apakah dialog pemilih tanggal tampil
    expect(find.text('OK'), findsOneWidget);

    // Mengetuk 'OK' pada dialog pemilih tanggal untuk memilih tanggal
    await tester.tap(find.text('OK').last);
    await tester.pumpAndSettle();

  });
}
