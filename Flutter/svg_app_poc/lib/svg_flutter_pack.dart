import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgFlutterPack extends StatelessWidget {
  const SvgFlutterPack({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text('SvgFlutterPack'),
            SvgPicture.asset('assets/confirmar.svg', height: 25, width: 25),
            SvgPicture.asset('assets/petalas_icon.svg'),
          ],
        ),
      ),
    );
  }
}
