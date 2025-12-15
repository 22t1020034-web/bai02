import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _bmiResult = '';
  String _bmiCategory = '';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _categorizeBMI(double bmi) {
    String category;
    if (bmi < 18.5) {
      category = 'Thiếu cân';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      category = 'Bình thường';
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      category = 'Thừa cân';
    } else {
      category = 'Béo phì';
    }

    setState(() {
      _bmiResult = 'Chỉ số BMI: ${bmi.toStringAsFixed(2)}, ';
      _bmiCategory = 'Phân loại: $category';
    });
  }

  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text);
    final double? heightCm = double.tryParse(_heightController.text);

    if (weight == null || heightCm == null || heightCm <= 0) {
      setState(() {
        _bmiResult = 'Vui lòng nhập số liệu hợp lệ.';
        _bmiCategory = '';
      });
      return;
    }

    final double heightM = heightCm / 100;
    final double bmi = weight / (heightM * heightM);

    _categorizeBMI(bmi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tính chỉ số BMI'),
        backgroundColor: const Color.fromARGB(255, 178, 12, 178),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Chiều cao (cm)',
                hintText: 'Ví dụ: 164',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cân nặng (kg)',
                hintText: 'Ví dụ: 50',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color.fromARGB(255, 208, 14, 169),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'TÍNH BMI',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Column(
                children: [
                  const Divider(height: 15, color: Colors.teal),
                  Text(
                    _bmiResult.isEmpty ? 'Chưa có kết quả' : _bmiResult,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _bmiResult.isEmpty
                          ? const Color.fromARGB(255, 9, 127, 167)
                          : const Color.fromARGB(255, 197, 236, 114),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _bmiCategory,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
