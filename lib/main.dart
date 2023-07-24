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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
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

class RandomWord extends StatelessWidget {
  const RandomWord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(80),
        child: Consumer<RandomWordModel>(
            builder: (context, randomWordState, child) => Column(children: [
                  Text(randomWordState.current.asLowerCase, style: style),
                  ElevatedButton(
                    onPressed: () {
                      randomWordState.getNext();
                    },
                    child: Text('Next Random Word Pair State'),
                  ),
                ])),
      ),
    );
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
            RandomWord(),
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
            ElevatedButton(
              onPressed: () {
                Provider.of<ClockModel>(context, listen: false).getNext();
              },
              child: Text('Next Clock State'),
            ),
          ],
        ),
      ),
    );
  }
}
