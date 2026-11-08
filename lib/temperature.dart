enum ConversionType {
  celsiusToFahrenheit('Celsius to Fahrenheit (°C → °F)', '°F'),
  fahrenheitToCelsius('Fahrenheit to Celsius (°F → °C)', '°C');

  const ConversionType(this.label, this.resultUnit);

  final String label;
  final String resultUnit;

  double convert(double value) {
    switch (this) {
      case ConversionType.celsiusToFahrenheit:
        return (value * 9 / 5) + 32;
      case ConversionType.fahrenheitToCelsius:
        return (value - 32) * 5 / 9;
    }
  }
}
