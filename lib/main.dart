import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

int count = 0;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  increment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    count++;
    setState(() {});
    pref.setInt("countValue", count);
  }
  decrement() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    count--;
    setState(() {});
    pref.setInt("countValue", count);
  }

  @override
  void initState() {
    action();
    super.initState();
  }

  action() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? countValue = pref.getInt("countValue");
    count = countValue!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade50,
        title: const Center(child: Text("Counter")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                flex: 85,
                child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CircularPercentIndicator(
                      radius: 69.0,
                      lineWidth: 10.0,
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: count / 100,
                      backgroundColor: Colors.deepPurple.shade100,
                      progressColor: Colors.deepPurple,
                      center: Text(
                        count.toString(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 15,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        decrement();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.minus,
                          size: 50,
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        increment();
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.plus,
                          size: 50,
                        ),
                      ),
                    )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
