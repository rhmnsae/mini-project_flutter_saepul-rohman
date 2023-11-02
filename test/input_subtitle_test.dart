import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_subtitle.dart';

void main() {
  testWidgets('SubtitleInput UI test', (WidgetTester tester) async {
    final subtitleController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SubtitleInput(subtitleController: subtitleController),
        ),
      ),
    );

    // Memverifikasi apakah TextFormField ada.
    expect(find.byType(TextFormField), findsOneWidget);

    // Memeriksa teks yang diinput di TextFormField.
    await tester.enterText(find.byType(TextFormField), 'Contoh Subtitle');
    expect(subtitleController.text, 'Contoh Subtitle');
  });
}
