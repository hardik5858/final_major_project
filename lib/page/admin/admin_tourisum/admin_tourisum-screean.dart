import 'package:final_major_project/backend/variable_data.dart';
import 'package:final_major_project/page/admin/fair_fastival.dart';
import 'package:flutter/material.dart';

import 'admin_tourisum.dart';
import 'admin_tourium_fair_and_festiva_add_data.dart';

class Admin_Tourisum_Screen extends StatefulWidget {
  const Admin_Tourisum_Screen({super.key});

  @override
  State<Admin_Tourisum_Screen> createState() => _Admin_Tourisum_ScreenState();
}

class _Admin_Tourisum_ScreenState extends State<Admin_Tourisum_Screen> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  late String appBarTitale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController(length: 2, vsync: this);
    appBarTitale="Tourisum";

    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            appBarTitale = "Top Destination";
            break;
          case 1:
            appBarTitale = "Fair And Fastival";
            break;
          case 2:
            appBarTitale = "Another Tab";
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tourisum ${appBarTitale}"),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(child: Text("Top Destination"),),
                Tab(child: Text("F&F"),),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Admin_Tourisum(),
              FAF()
            ],)
        )
    );
  }
}
