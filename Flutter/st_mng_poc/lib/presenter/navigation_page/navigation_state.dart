enum NavigationBarItem { home, favorites }

class NavigationState {
  final NavigationBarItem navbarItem;
  final int index;

  NavigationState({
    required this.index,
    this.navbarItem = NavigationBarItem.home,
  });

  factory NavigationState.home() => NavigationState(index: 0);

  factory NavigationState.favorites() =>
      NavigationState(index: 1, navbarItem: NavigationBarItem.favorites);
}
