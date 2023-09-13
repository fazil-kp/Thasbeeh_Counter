import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
    });
  }

  _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }

  counterFunction() {
    setState(() {
      counter++;
      _saveCounter(); // Save the counter value when it changes
    });
  }

  decrementFunction() {
    setState(() {
      if (counter > 0) {
        counter--;
        _saveCounter();
      }
    });
  }

  resetFunction() {
    setState(() {
      counter = 0;
      _saveCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        // leading: BackButton(
        //   color: Colors.white,
        //   onPressed: () {},
        // ),
        title: const Text("Dhikr Counter"),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Thasbeeh",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text("$counter",
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 80.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              tooltip: "Click Here",
              child: const Icon(Icons.remove),
              onPressed: () {
                decrementFunction();
              },
            ),
          ),
          Positioned(
            bottom: 150.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              tooltip: "Click Here",
              child: const Icon(Icons.add),
              onPressed: () {
                counterFunction();
              },
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              tooltip: "Click Here",
              child: const Icon(Icons.refresh),
              onPressed: () {
                resetFunction();
              },
            ),
          ),
        ],
      ),
    );
  }
}
