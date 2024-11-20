import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

enum Gender { male, female }

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  int weight = 70;
  int age = 23;
  double height = 170.0;
  String bmiResult = '';
  String bmiCategory = 'Underweight';
  Gender? selectedGender = Gender.male;


  void calculateBMI() {
    double bmi = weight / ((height / 100) * (height / 100));
    setState(() {
      bmiResult = bmi.toStringAsFixed(1);
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
      } else if (bmi < 24.9) {
        bmiCategory = 'Normal';
      } else if (bmi < 29.9) {
        bmiCategory = 'Overweight';
      } else {
        bmiCategory = 'Obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0EAFD),
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Color(0xFF3B5998),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Welcome 😊\nBMI Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderButton(
                  icon: Icons.male,
                  label: 'Male',
                  selected: selectedGender == Gender.male,
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                ),
                SizedBox(width: 16),
                GenderButton(
                  icon: Icons.female,
                  label: 'Female',
                  selected: selectedGender == Gender.female,
                  onTap: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IncrementCard(
                  label: 'Weight',
                  value: weight.toString(),
                  onIncrement: () {
                    setState(() {
                      weight++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      weight--;
                    });
                  },
                ),
                IncrementCard(
                  label: 'Age',
                  value: age.toString(),
                  onIncrement: () {
                    setState(() {
                      age++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      age--;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Height',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter height in cm',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                height = double.parse(value);
              },
            ),
            SizedBox(height: 20),
            Text(
              '$bmiResult',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              '$bmiCategory',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Let's Go"),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  GenderButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.blue : Colors.grey,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    );
  }
}

class IncrementCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  IncrementCard({
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: Icon(Icons.remove_circle, size: 32),
                ),
                IconButton(
                  onPressed: onIncrement,
                  icon: Icon(Icons.add_circle, size: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
