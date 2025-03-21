enum NavigationBarItem { home, favorites }

class NavigationState {
  final NavigationBarItem navbarItem;
  final int index;

  NavigationState({
    required this.navbarItem,
    required this.index,
  });
}
