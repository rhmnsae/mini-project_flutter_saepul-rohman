import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_description.dart';

void main() {
  testWidgets('DescriptionInput UI test', (WidgetTester tester) async {
    final descriptionController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DescriptionInput(descriptionController: descriptionController),
        ),
      ),
    );

    // Memverifikasi apakah TextFormField ada.
    expect(find.byType(TextFormField), findsOneWidget);

    // Memeriksa teks yang diinput di TextFormField.
    await tester.enterText(find.byType(TextFormField), 'Deskripsi contoh');
    expect(descriptionController.text, 'Deskripsi contoh');
  });
}
