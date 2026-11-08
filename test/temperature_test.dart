import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_converter/temperature.dart';

void main() {
  test('converts Celsius to Fahrenheit', () {
    expect(
      ConversionType.celsiusToFahrenheit.convert(0),
      32,
    );
    expect(
      ConversionType.celsiusToFahrenheit.convert(100),
      212,
    );
    expect(
      ConversionType.celsiusToFahrenheit.convert(-40),
      -40,
    );
  });

  test('converts Fahrenheit to Celsius', () {
    expect(
      ConversionType.fahrenheitToCelsius.convert(32),
      0,
    );
    expect(
      ConversionType.fahrenheitToCelsius.convert(212),
      closeTo(100, 0.000001),
    );
    expect(
      ConversionType.fahrenheitToCelsius.convert(72),
      closeTo(22.222222, 0.000001),
    );
  });
}
