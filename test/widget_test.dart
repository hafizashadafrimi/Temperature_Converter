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
    expect(
      find.text('Fahrenheit to Celsius (°F → °C)'),
      findsOneWidget,
    );
  });
}
