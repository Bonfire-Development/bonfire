import 'dart:ffi';
import 'dart:io';

import 'package:bonfire/colors.dart';
import 'package:bonfire/components/sidebar/sidebar.dart';
import 'package:bonfire/globals.dart';
import 'package:bonfire/network/auth.dart';
import 'package:bonfire/style.dart';
import 'package:bonfire/views/home/channels.dart';
import 'package:bonfire/views/home/overlapping_panels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nyxx/nyxx.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final client = ModalRoute.of(context)!.settings.arguments as NyxxGateway;
    globalClient = client;

    return const MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OverlappingPanels(
      left: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Sidebar(),
            const Expanded(child: ChannelList())
          ],
        ),
      ),
      main: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: foreground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ]))
    ));
  }
}
