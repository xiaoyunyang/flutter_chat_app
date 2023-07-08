import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  var providers = [
    ChangeNotifierProvider(create: (context) => ClockModel()),
    ChangeNotifierProvider(create: (context) => RandomWordModel()),
  ];
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClockModel(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class ClockModel extends ChangeNotifier {
  var current = "tick";

  void getNext() {
    current = current == "tick" ? "tock" : "tick";
    notifyListeners();
  }
}

class RandomWordModel extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<RandomWordModel>(
                builder: (context, randomWordState, child) => Column(children: [
                      Text(randomWordState.current.asLowerCase),
                      ElevatedButton(
                        onPressed: () {
                          randomWordState.getNext();
                        },
                        child: Text('Next Random Word Pair State'),
                      ),
                    ])),
            Consumer<ClockModel>(
                builder: (context, clockState, child) => (Column(children: [
                      Text(clockState.current),
                      ElevatedButton(
                        onPressed: () {
                          clockState.getNext();
                        },
                        child: Text('Next Clock State'),
                      ),
                    ]))),
          ],
        ),
      ),
    );
  }
}
