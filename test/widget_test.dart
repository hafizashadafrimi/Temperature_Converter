import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_converter/main.dart';

void main() {
  testWidgets('shows the converter layout', (WidgetTester tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());

    expect(find.text('Temperature converter'), findsOneWidget);
    expect(find.text('Degrees'), findsOneWidget);
    expect(find.text('Type'), findsOneWidget);
    expect(find.text('Result'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
    expect(find.text('Fahrenheit to Celsius (°F → °C)'), findsOneWidget);
  });

  testWidgets('converts 72 Fahrenheit to Celsius', (WidgetTester tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());

    await tester.enterText(find.byKey(const Key('degrees-field')), '72');
    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();

    expect(find.text('22.22 °C'), findsOneWidget);
  });

  testWidgets('converts 100 Celsius to Fahrenheit', (WidgetTester tester) async {
    await tester.pumpWidget(const TemperatureConverterApp());

    await tester.tap(find.byKey(const Key('conversion-type')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Celsius to Fahrenheit (°C → °F)').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('degrees-field')), '100');
    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();

    expect(find.text('212.00 °F'), findsOneWidget);
  });

  testWidgets('shows an error when the field is empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TemperatureConverterApp());

    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();

    expect(find.text('Please enter a temperature value.'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const Key('result-text'))).data,
      '',
    );
  });

  testWidgets('shows an error when the value is not a number', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TemperatureConverterApp());

    await tester.enterText(find.byKey(const Key('degrees-field')), '72');
    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();
    expect(find.text('22.22 °C'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('degrees-field')), 'abc');
    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();

    expect(find.text('Please enter a valid number.'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const Key('result-text'))).data,
      '',
    );
  });

  testWidgets('clears the error after a valid conversion', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TemperatureConverterApp());

    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();
    expect(find.text('Please enter a temperature value.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('degrees-field')), '32');
    await tester.tap(find.byKey(const Key('convert-button')));
    await tester.pump();

    expect(find.text('Please enter a temperature value.'), findsNothing);
    expect(find.text('0.00 °C'), findsOneWidget);
  });
}
