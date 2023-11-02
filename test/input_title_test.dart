import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_title.dart';

void main() {
  testWidgets('TitleInput UI test', (WidgetTester tester) async {
    final titleController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TitleInput(titleController: titleController),
        ),
      ),
    );

    // Memeriksa apakah TextFormField untuk judul muncul.
    expect(find.byType(TextFormField), findsOneWidget);

    // Memeriksa apakah judul yang dimasukkan sesuai.
    await tester.enterText(find.byType(TextFormField), 'Example Title');
    expect(titleController.text, 'Example Title');
  });
}
