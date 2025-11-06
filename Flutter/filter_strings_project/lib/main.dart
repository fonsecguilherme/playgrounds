import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/*
 * List of colors screen populated view in a list view and when
 * add textfield that will filter the list as i type
 * if a type G it would show green
no matcher the list would be lank and if the textfield is blank it would show all colors
 *
 * */

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final colorsList = ['Red', 'Green', 'Blue', 'White', 'Black'];

  List<String> resultList = [];

  final textInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textInput,
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    resultList = List.from(colorsList);
                  } else {
                    resultList = colorsList
                        .where(
                          (color) =>
                              color.toLowerCase().contains(value.toLowerCase()),
                        )
                        .toList();
                  }
                });
              },
            ),

            Expanded(
              child: ListView.builder(
                itemCount: resultList.length,
                itemBuilder: (context, index) {
                  final color = resultList[index];
                  return ListTile(title: Text(color));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//! Sem precisar manipular a lista original

// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(colorSchemeSeed: Colors.blue),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// /*
//  * List of colors screen populated view in a list view and when
//  * add textfield that will filter the list as i type
//  * if a type G it would show green
// no matcher the list would be lank and if the textfield is blank it would show all colors
//  *
//  * */

// class MyHomePage extends StatefulWidget {
//   final String title;

//   const MyHomePage({super.key, required this.title});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final colorsList = ['Red', 'Green', 'Blue', 'White', 'Black'];

//   final textInput = TextEditingController();

//   List<String> getElements(String value) {
//     if (value.isEmpty) return colorsList;

//     return colorsList
//         .where((color) => color.toLowerCase().contains(value.toLowerCase()))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(controller: textInput),

//             Expanded(
//               child: AnimatedBuilder(
//                 animation: textInput,
//                 builder: (context, _) {
//                   final elements = getElements(textInput.text);

//                   if (elements.isEmpty) {
//                     return Center(child: Text('Empty list'));
//                   }

//                   return ListView.builder(
//                     itemCount: elements.length,
//                     itemBuilder: (context, index) {
//                       final color = elements.elementAt(index);
//                       return Text(color);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
