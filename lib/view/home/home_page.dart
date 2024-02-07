import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/view/service/notification_service/notification_service.dart';
import 'comp_task_page/comp_task_page.dart';
import 'task_page/task_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

part 'notification_perm_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    notificationPermissionFunc(context);
    NotificationService().notificationInitialization();
  }

  @override
  Widget build(context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [buildAppBar(context)];
            },
            body: buildBody(),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
          pinned: true,
          floating: true,
          leading: null,
          centerTitle: true,
          title: const Text(
            "Jungle",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: appBarActionWidget(),
          bottom: tabBarWidget(),
        ),
      ),
    );
  }

  List<Widget> appBarActionWidget() {
    return [
      IconButton(
        onPressed: () => Get.toNamed("/settings"),
        icon: const Icon(
          Icons.settings_outlined,
        ),
      ),
    ];
  }

  TabBar tabBarWidget() {
    return TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorWeight: 5,
        splashBorderRadius: BorderRadius.circular(10),
        labelStyle: TextStyle(
          fontFamily: Platform.localeName == "en" ? "Lato" : "Vazirmatn",
          fontWeight: FontWeight.bold),
        tabs: tabListWidget());
  }

  List<Tab> tabListWidget() {
    return [
      Tab(child: Text(AppLocalizations.of(context)!.firstTabButtonTitle)),
      Tab(child: Text(AppLocalizations.of(context)!.secondTabButtonTitle)),
    ];
  }

  Widget buildBody() {
    return const TabBarView(children: [TaskPage(), CompTaskPage()]);
  }
}
