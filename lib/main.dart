import 'package:tip_calculator_app/tip_slider.dart';

import 'person_counter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'uTip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  //Variables
  int _personCount = 1;

  double _tipPercentage = 0.0;

  //Methods
  void increment() {
    setState(() {
      _personCount++;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount > 1) {
        //becase tipping person has to be 1 at least for the tipping to make sense
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(context.owner.toString()); writing this code causes error
    var theme = Theme.of(context);
    //Add style
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('uTip')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text('Total per person', style: style),
                  Text(
                    "\$23.89",
                    style: style.copyWith(
                      // color: theme.colorScheme.primary,
                      fontSize: theme.textTheme.displaySmall!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Form
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                      labelText: "Bill Amount",
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  //Split Bill area
                  PersonCounter(
                    theme: theme,
                    personCount: _personCount,
                    onIncrement: increment,
                    onDecrement: decrement,
                  ),
                  // == Tip Section ==
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip', style: theme.textTheme.titleMedium),
                      Text('\$20', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  // == Slider Text ==
                  Text('${(_tipPercentage * 100).round()}%'),

                  // == Slider ==
                  TipSlider(
                    tipPercentage: _tipPercentage,
                    onChanged: (double value) {
                      setState(() {
                        _tipPercentage = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
