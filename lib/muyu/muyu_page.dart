import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'count_panel.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({Key? key}) : super(key: key);

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("电子木鱼"),
        actions: [
          IconButton(onPressed: _toHistory, icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CountPanel(
              count: 0,
              onTapSwitchAudio: _onTapSwitchAudio,
              onTapSwitchImage: _onTapSwitchImage,
            ),
          ),
          Expanded(child: _buildImage()),
        ],
      ),
    );
  }

  void _toHistory() {}

  Widget _buildImage() {
    return Center(
        child: Image.asset(
      'assets/images/muyu.png',
      height: 200,
    ));
  }

  void _onTapSwitchAudio() {}

  void _onTapSwitchImage() {}
}
