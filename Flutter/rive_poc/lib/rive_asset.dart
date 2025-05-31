import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, srcLight, srcDark;
  late SMIBool? input;

  RiveAsset({
    required this.srcLight,
    required this.srcDark,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
    srcDark: 'assets/animated_icons.riv',
    srcLight: 'assets/animated_icons_white.riv',
    artboard: 'HOME',
    stateMachineName: 'HOME_interactivity',
    title: 'Home',
  ),
  RiveAsset(
    srcDark: 'assets/animated_icons.riv',
    srcLight: 'assets/animated_icons_white.riv',
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Search',
  ),
  RiveAsset(
    srcDark: 'assets/animated_icons.riv',
    srcLight: 'assets/animated_icons_white.riv',
    artboard: 'LIKE/STAR',
    stateMachineName: 'STAR_Interactivity',
    title: 'Like',
  )
];
// List<RiveAsset> whiteBottomNavItems = [
//   RiveAsset(
//     'assets/animated_icons_white.riv',
//     artboard: 'HOME',
//     stateMachineName: 'HOME_interactivity',
//     title: 'Home',
//   ),
//   RiveAsset(
//     'assets/animated_icons_white.riv',
//     artboard: 'SEARCH',
//     stateMachineName: 'SEARCH_Interactivity',
//     title: 'Search',
//   ),
//   RiveAsset(
//     'assets/animated_icons_white.riv',
//     artboard: 'LIKE/STAR',
//     stateMachineName: 'STAR_Interactivity',
//     title: 'Like',
//   ),
// ];
