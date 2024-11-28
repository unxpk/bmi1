import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );


  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  double _weight = 0.0;
  double _height = 0.0;
  double _bmi = 0.0;
  String _outputBMI = '';
  late AssetImage _imageBMI;

  @override
  void dispose() {
    //Remove memory allocated to TextField Controller
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageBMI = const AssetImage('assets/empty.png');
  }

  void _calculateBMI() {
    setState(() {
      //Retrieve value from TextField
      _weight = double.parse(weightController.text);
      _height = double.parse(heightController.text);
      //Calculate BMI
      _bmi = _weight / pow(_height / 100, 2);
      intl.NumberFormat formatter = intl.NumberFormat('0.00');
      _outputBMI = formatter.format(_bmi);

      // Determine BMI category
      if (_bmi < 18.5) {
        _imageBMI = const AssetImage('assets/under.png');
      } else if (_bmi > 25) {
        _imageBMI = const AssetImage('assets/over.png');
      } else {
        _imageBMI = const AssetImage('assets/normal.png');
      }
    });
  }


  @override
  Widget build(BuildContext context) {


      return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField( //Enter body weight (kg)
              controller: weightController,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: 'Enter weight (kg)',
              ),
            ),
            TextField( //Enter body height (cm)
              controller: heightController,
              keyboardType: TextInputType.number,
              textDirection: TextDirection.ltr,
              decoration: const InputDecoration(
                labelText: 'Enter height (cm)',
              ),
            ),
            const Text(
              'Your Body Mass Index (BMI):',
            ),
            Text(
              '$_outputBMI',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text('Calculate BMI'),
            ),
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
              strokeAlign: 1.0,
            ),
            image: DecorationImage(
              image: _imageBMI,
              fit: BoxFit.fitHeight,
            ),
          ),
        )
          ],
        ),
      ),
    );
  }
}
