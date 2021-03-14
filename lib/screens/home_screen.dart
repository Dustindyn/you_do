import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './dashboard_page.dart';
import './calendar_page.dart';
import './category_page.dart';
import './balance_chart_page.dart';
import './new_task_popup_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _showTaskDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => NewTaskPopupScreen());
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Theme.of(context).buttonColor),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _showTaskDialog(context),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          FaIcon(FontAwesomeIcons.tachometerAlt,
              color: Theme.of(context).buttonColor),
          FaIcon(FontAwesomeIcons.calendarWeek,
              color: Theme.of(context).buttonColor),
          FaIcon(FontAwesomeIcons.users, color: Theme.of(context).buttonColor),
          FaIcon(FontAwesomeIcons.chartPie,
              color: Theme.of(context).buttonColor),
        ],
        onTap: (index) {
          setState(() {
            _controller.animateToPage(index,
                duration: Duration(
                  milliseconds: 500,
                ),
                curve: Curves.ease);
          });
        },
        backgroundColor: Colors.transparent,
        color: Theme.of(context).primaryColor,
        buttonBackgroundColor: Colors.transparent,
        height: 50,
      ),
      body: Container(
        margin: MediaQuery.of(context).padding,
        padding: const EdgeInsets.only(top: 30),
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          children: [
            DashboardPage(),
            CalendarPage(),
            CategoryPage(),
            BalanceChartPage(),
          ],
        ),
      ),
    );
  }
}
