import 'package:combine/flavour.dart';
import 'package:combine/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(Provider<Flavor>.value(
    value: Flavor.prod,
      child: MaterialApp(
      home: HomePage(),
    ),
  ));
}