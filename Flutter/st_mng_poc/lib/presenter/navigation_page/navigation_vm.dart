import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:st_mng_poc/presenter/navigation_page/navigation_state.dart';

class NavigationVm {
  var state = ValueNotifier<NavigationState>(NavigationState.home());

  Future<void> changeTab(NavigationState tab) async {
    state.value = tab;

    log(state.value.navbarItem.name);
  }
}
