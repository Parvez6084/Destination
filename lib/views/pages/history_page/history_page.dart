import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../home_page/homePageController.dart';

class HistoryPage extends GetView<HomePageController> {
  final ScrollController scrollController;
  const HistoryPage( this.scrollController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        width: MediaQuery.of(context).size.width * 0.67,
        child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(color: Colors.deepOrange, height: 16, width: 4,),
                  const SizedBox(width: 8,),
                  const Text('History', style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold,),)
                ],),
              const SizedBox(height: 16,),
              Container(
                color: Colors.white30,
                child: Table(
                  columnWidths: const {
                    0:FractionColumnWidth(0.01),
                    1:FractionColumnWidth(0.2),
                    2:FractionColumnWidth(0.08),
                    3:FractionColumnWidth(0.2),
                    4:FractionColumnWidth(0.1),
                  },
                  children: [controller.buildRowHeader(['No.','Searched Location','Distance','Estimated Time','Timestamp'])],
                ),
              ),
              Container(
                color: Colors.white10,
                child: Table(
                  columnWidths: const {
                    0:FractionColumnWidth(0.01),
                    1:FractionColumnWidth(0.2),
                    2:FractionColumnWidth(0.08),
                    3:FractionColumnWidth(0.2),
                    4:FractionColumnWidth(0.1),
                  },
                  border:  TableBorder.all(),
                  children: [
                    controller.buildRow(['1','Demra, Dhaka','3','24min','34-3494']),
                    controller.buildRow(['2','Sarulia Bazar, Dhaka','30min','24min','34-3494']),
                    controller.buildRow(['3','Prantha Path, Dhaka','3 min','24min','34-3494']),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
