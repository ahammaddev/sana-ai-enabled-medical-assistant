import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/global_controller.dart';

class GlobalView extends GetView<GlobalController> {
  const GlobalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlobalView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GlobalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
