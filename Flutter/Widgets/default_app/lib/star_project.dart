import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
    _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: StarRating(
          color: Colors.red,
          rating: 3.3,
          starCount: 5,
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;

  const StarRating({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    required this.color,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    // Verifica se o índice está dentro do rating inteiro
    if (index < rating.floor()) {
      icon = const Icon(
        Icons.star,
        color: Colors.black,
      );
    }
    // Se o índice é igual ao rating inteiro, mas há uma parte decimal menor que 0.5
    else if (index == rating.floor() && rating - rating.floor() < 0.5) {
      icon = const Icon(
        Icons.star_border,
        color: Colors.black,
      );
    }
    // Se o índice é igual ao rating inteiro, mas há uma parte decimal maior ou igual a 0.5
    else /*if (index == rating.floor() && rating - rating.floor() >= 0.5)*/ {
      icon = const Icon(
        Icons.star,
        color: Colors.black,
      );
    }
    // Se o índice é maior que o rating inteiro, exibe star_border
    // else {
    //   icon = const Icon(
    //     Icons.star_border,
    //     color: Colors.black,
    //   );
    // }
    return InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
