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
      debugShowCheckedModeBanner: false,
      title: 'Counter Demo',
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: const Text("Demo App"),
        ),
        body: const Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<String> images = [
    "https://catracalivre.com.br/wp-content/uploads/sites/11/2016/02/1rd_Praia-de-Ponta-Verde_by_-Wesley-Menegari.jpg",
    "https://images.unsplash.com/photo-1632415978225-ffe0d0f2703e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80",
    "http://experimentemaceio.com.br/wp-content/uploads/2022/05/BALANCO-SANTA-AMELIA.jpeg",
    "http://experimentemaceio.com.br/wp-content/uploads/2022/06/30-12-21-Maceio-e-Massa-Eu-Amo-MCZ-Mirante-Jatiuca-SEMTEL-Foto-Maivan-Fernandez-7.jpg",
    "https://www.salinas.com.br/uploads/blog/images/5f85c4e22dfed.a-noite-em-maceio.jpg"
  ];

  int _index = 0;
  String _image =
      "https://catracalivre.com.br/wp-content/uploads/sites/11/2016/02/1rd_Praia-de-Ponta-Verde_by_-Wesley-Menegari.jpg";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IndexedStack(
        index: _index,
        children: [
          GridView.builder(
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onLongPress: () {
                  setState(() {
                    _index = 1;
                    _image =
                        images[index]; /*"assets/images/${images[index]}";*/
                  });
                },
                onLongPressEnd: (details) {
                  setState(() {
                    _index = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(images[
                          index]) /*Image.asset("assets/images/${images[index]}"),*/
                      ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 400,
                  maxWidth: 400,
                ),
                child: Image.network(
                  _image,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
