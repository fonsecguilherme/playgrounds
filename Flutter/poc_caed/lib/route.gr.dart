// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:poc_caed/pages/counter_controller.dart' as _i5;
import 'package:poc_caed/pages/home_page.dart' as _i1;
import 'package:poc_caed/pages/second_page.dart' as _i2;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.SecondPage]
class SecondRoute extends _i3.PageRouteInfo<SecondRouteArgs> {
  SecondRoute({
    _i4.Key? key,
    required _i5.CounterController controller,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          SecondRoute.name,
          args: SecondRouteArgs(
            key: key,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'SecondRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SecondRouteArgs>();
      return _i2.SecondPage(
        key: args.key,
        controller: args.controller,
      );
    },
  );
}

class SecondRouteArgs {
  const SecondRouteArgs({
    this.key,
    required this.controller,
  });

  final _i4.Key? key;

  final _i5.CounterController controller;

  @override
  String toString() {
    return 'SecondRouteArgs{key: $key, controller: $controller}';
  }
}
