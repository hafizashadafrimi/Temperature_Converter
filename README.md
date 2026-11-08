# Temperature_Converter

A Flutter temperature converter. Enter a value, choose a conversion, and press Convert.

## What it does

- Accepts a temperature in the Degrees field
- Converts Celsius to Fahrenheit or Fahrenheit to Celsius
- Shows the result to 2 decimal places
- Shows an error when the field is empty or is not a number

## Formulas

- Celsius to Fahrenheit: F = (C × 9/5) + 32
- Fahrenheit to Celsius: C = (F − 32) × 5/9

Values stay in the screen's own state. This app does not use a database.

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```
