// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_app/model/nav_item_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selectedNavIndex = 0;

  List<Widget> pages = [
    const Center(child: Text('Home')),
    ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => ListTile(
        title: Text('Item $index'),
      ),
    ),
    const Center(child: Text('Profile')),
  ];

  void animateIcon(int index) {
    riveIconInputs.elementAt(index).change(true);

    Future.delayed(const Duration(seconds: 1), () {
      riveIconInputs.elementAt(index).change(false);
    });
  }

  void riveOnInit(
      {required Artboard artboard, required String stateMachineName}) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );

    if (controller != null) {
      artboard.addController(controller);

      controllers.add(controller);

      riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Mostra a página selecionada
            IndexedStack(
              index: selectedNavIndex,
              children: pages,
            ),
            // BottomNavigationBar sobreposto
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24,
                  ),
                  margin:
                      const EdgeInsets.only(right: 48.0, bottom: 8, left: 48.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent.withValues(alpha: 0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF17203A).withValues(alpha: 0.3),
                        offset: const Offset(0, 20),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      bottomNavItems.length,
                      (index) {
                        final icon = bottomNavItems.elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            animateIcon(index);

                            setState(() {
                              selectedNavIndex = index;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              AnimatedBar(
                                isActive: selectedNavIndex == index,
                              ),
                              SizedBox(
                                height: 36,
                                width: 36,
                                child: Opacity(
                                  opacity: selectedNavIndex == index ? 1 : 0.5,
                                  child: RiveAnimation.asset(
                                    icon.rive.src,
                                    artboard: icon.rive.artboard,
                                    onInit: (artboard) => riveOnInit(
                                      artboard: artboard,
                                      stateMachineName: icon.rive.stateMachine,
                                    ),
                                  ),
                                ),
                              ),
                              const Text('Home')
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(
          bottom: 2.0,
        ),
        height: 4,
        width: isActive ? 20 : 0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      );
}



// ListView.builder(
//   itemCount: 50,
//   itemBuilder: (context, index) => const Text('text'),
// ),
// bottomNavigationBar: SafeArea(
//   child: Container(
//     padding: EdgeInsets.symmetric(
//       vertical: 12.0,
//       horizontal: 24,
//     ),
//     margin: EdgeInsets.symmetric(horizontal: 48.0),
//     decoration: BoxDecoration(
//       color: Colors.deepPurpleAccent.withValues(alpha: 0.8),
//       borderRadius: BorderRadius.all(Radius.circular(24.0)),
//       boxShadow: [
//         BoxShadow(
//           color: Color(0xFF17203A).withValues(alpha: 0.3),
//           offset: Offset(0, 20),
//           blurRadius: 20,
//         ),
//       ],
//     ),
//     child: Row(

//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: List.generate(
//         bottomNavItems.length,
//         (index) {
//           final icon = bottomNavItems.elementAt(index);

//           return GestureDetector(
//             onTap: () => animateIcon(index),
//             child: SizedBox(
//               height: 36,
//               width: 36,
//               child: RiveAnimation.asset(
//                 icon.rive.src,
//                 artboard: icon.rive.artboard,
//                 onInit: (artboard) => riveOnInit(
//                   artboard: artboard,
//                   stateMachineName: icon.rive.stateMachine,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   ),
// ),

// Center(
//           child: RiveAnimation.network(
//             'https://cdn.rive.app/animations/vehicles.riv',
//             fit: BoxFit.cover,
//           ),
//         ),


