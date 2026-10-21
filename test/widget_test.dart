import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mws_praktik/main.dart';

void main() {
  testWidgets('login valid membawa pengguna ke halaman utama', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final fields = find.byType(TextFormField);
    await tester.ensureVisible(fields.at(0));
    await tester.enterText(fields.at(0), 'Nama Pengguna');
    await tester.enterText(fields.at(1), '081234567890');
    await tester.enterText(fields.at(2), 'pengguna');
    await tester.enterText(fields.at(3), 'rahasia123');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Halaman Utama'), findsOneWidget);
    expect(find.text('SELAMAT DATANG!'), findsOneWidget);
    expect(find.byKey(const ValueKey('imageCarousel')), findsOneWidget);
    await tester.drag(
      find.byKey(const ValueKey('innerContentList')),
      const Offset(0, -600),
    );
    await tester.pumpAndSettle();
    expect(find.text('Konten 10'), findsOneWidget);
  });

  testWidgets('login tidak valid tetap di halaman login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final submitButton = find.byType(FilledButton);
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
    expect(find.text('Bagian ini wajib diisi'), findsWidgets);
    expect(find.text('Halaman Utama'), findsNothing);
  });
}
