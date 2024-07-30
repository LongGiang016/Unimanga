import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/modules/book_case/views/book_case_view.dart';
import 'package:unimanga_app/app/modules/dashboard/views/dashboard_views.dart';
import 'package:unimanga_app/app/modules/infor_user/views/profile_screen.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key, this.user});
  User? user;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    BookCaseView(),
    ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Truyện',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Tủ sách',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: 'Tài khoản',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.RedPrimary,
          onTap: _onItemTapped),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
