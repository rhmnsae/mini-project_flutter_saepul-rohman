import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_list/Providers/add_todo_provider.dart';
import 'package:simple_todo_list/Pages/Views/widgets/input_category.dart';

void main() {
  testWidgets('UI Testing for CategoryInput', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => TodoProvider(),
          child: const Scaffold(
            body: CategoryInput(),
          ),
        ),
      ),
    );

    // Memeriksa apakah tiga prioritas kategori muncul.
    expect(find.byType(GestureDetector), findsNWidgets(3));
  });
}
