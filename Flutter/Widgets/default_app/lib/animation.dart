import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Mat3AppWidget()));
}

class Mat3AppWidget extends StatefulWidget {
  const Mat3AppWidget({super.key});

  @override
  State<Mat3AppWidget> createState() => _Mat3AppWidgetState();
}

class _Mat3AppWidgetState extends State<Mat3AppWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(begin: 0, end: 4 * 3.14).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
  }

  void _toggleAnimation() {
    setState(() {
      if (_isAnimating) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isAnimating = !_isAnimating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer Rotation'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: const Text(
                        'Rotate Me!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SecondPageWidget(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              // _toggleAnimation,
              child: const Icon(Icons.repeat_sharp),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SecondPageWidget extends StatelessWidget {
  const SecondPageWidget({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Segunda tela'),
        ),
        body: const Center(
          child: Text('Minha tela 2'),
        ),
      );
}
