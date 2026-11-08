import 'package:flutter/material.dart';
import 'package:temperature_converter/temperature.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F5FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007AFF)),
      ),
      home: const ConverterScreen(),
    );
  }
}

const TextStyle _labelStyle = TextStyle(
  fontSize: 13,
  color: Color(0xFF9AA0A8),
  fontWeight: FontWeight.w500,
);

const TextStyle _valueStyle = TextStyle(
  fontSize: 22,
  height: 1.2,
  color: Color(0xFF1C1C1E),
  fontWeight: FontWeight.w400,
);

const Color _lineColor = Color(0xFFE6E6EA);

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _degreesController = TextEditingController();
  ConversionType _type = ConversionType.fahrenheitToCelsius;
  String _result = '';

  @override
  void dispose() {
    _degreesController.dispose();
    super.dispose();
  }

  void _convert() {
    FocusManager.instance.primaryFocus?.unfocus();
    final value = double.tryParse(_degreesController.text.trim());
    if (value == null) {
      setState(() => _result = '');
      return;
    }

    final converted = _type.convert(value);
    setState(() {
      _result = '${converted.toStringAsFixed(2)} ${_type.resultUnit}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Temperature converter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C1C1E),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: _DegreesField(controller: _degreesController),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            flex: 3,
                            child: _TypeField(
                              value: _type,
                              onChanged: (value) {
                                setState(() => _type = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      const Text('Result', style: _labelStyle),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 32,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _result,
                            key: const Key('result-text'),
                            style: _valueStyle,
                          ),
                        ),
                      ),
                      const Divider(height: 1, thickness: 1, color: _lineColor),
                      const SizedBox(height: 28),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          key: const Key('convert-button'),
                          onPressed: _convert,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007AFF),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: const Text('Convert'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DegreesField extends StatelessWidget {
  const _DegreesField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Degrees', style: _labelStyle),
        TextField(
          key: const Key('degrees-field'),
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          style: _valueStyle,
          cursorColor: const Color(0xFF007AFF),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: _lineColor),
      ],
    );
  }
}

class _TypeField extends StatelessWidget {
  const _TypeField({required this.value, required this.onChanged});

  final ConversionType value;
  final ValueChanged<ConversionType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type', style: _labelStyle),
        DropdownButtonHideUnderline(
          child: DropdownButton<ConversionType>(
            key: const Key('conversion-type'),
            value: value,
            isExpanded: true,
            isDense: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF1C1C1E),
            ),
            borderRadius: BorderRadius.circular(12),
            style: _valueStyle.copyWith(fontSize: 15),
            items: ConversionType.values
                .map(
                  (type) => DropdownMenuItem<ConversionType>(
                    value: type,
                    child: Text(type.label, style: const TextStyle(fontSize: 14)),
                  ),
                )
                .toList(),
            onChanged: (selected) {
              if (selected != null) {
                onChanged(selected);
              }
            },
          ),
        ),
        const Divider(height: 1, thickness: 1, color: _lineColor),
      ],
    );
  }
}
