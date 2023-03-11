import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:talkonomy_app/core/radius/custom_radius.dart';
import 'package:talkonomy_app/features/chat/presentation/pages/chat_page_view.dart';
import 'package:talkonomy_app/features/user/presentation/pages/user_detail/user_detail_page_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  int currentIndex = 0;
  List<Widget> pages = [const Scaffold(), const ChatPageView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      bottomNavigationBar: _bottomNavigationBar(),
      body: pages[currentIndex],
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 80,
      title: Text(
        currentIndex == 1 ? "Chats" : "Contacts",
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 18.sp),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: InkWell(
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDetailPageView()));
              },
              child: const CircleAvatar()),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: () async {},
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: const Color(0xffFAFAFA), borderRadius: CustomRadius.size10()),
            child: Center(
                child: SvgPicture.asset(
              "assets/add-outline.svg",
              width: 35,
              height: 35,
              color: const Color(0xffA3A3A3),
            )),
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedFontSize: 13,
        unselectedFontSize: 13,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/person.svg",
              width: 25,
              height: 25,
            ),
            icon: SvgPicture.asset(
              "assets/person-outline.svg",
              width: 25,
              height: 25,
            ),
            tooltip: "",
            label: "Contacts",
          ),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/chatbubbles.svg",
                width: 25,
                height: 25,
              ),
              icon: SvgPicture.asset(
                "assets/chatbubbles-outline.svg",
                width: 25,
                height: 25,
              ),
              label: "Chats")
        ]);
  }
}
