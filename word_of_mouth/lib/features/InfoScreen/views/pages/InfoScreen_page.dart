import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/InfoScreen_controller.dart';

class InfoScreenPage extends GetView<InfoScreenController> {
    
    const InfoScreenPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('InfoScreenPage'),),
            body: Container(),
        );
    }
}