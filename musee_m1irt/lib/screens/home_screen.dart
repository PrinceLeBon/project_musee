import 'package:flutter/material.dart';
import 'package:musee_m1irt/components/add.dart';
import 'package:musee_m1irt/screens/bibliotheque_list.dart';
import 'package:musee_m1irt/screens/moment_list.dart';
import 'package:musee_m1irt/screens/musee_list.dart';
import 'package:musee_m1irt/screens/ouvrage_list.dart';
import 'package:musee_m1irt/screens/pays_list.dart';
import 'package:musee_m1irt/screens/visiter_list.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: PageView(
        onPageChanged: (index) => setState(() => _currentIndex = index),
        controller: _pageController,
        children: const [
          moment_list(),
          pays_list(),
          musee_list(),
          bibliotheque_list(),
          visiter_list(),
          ouvrage_list(),
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => _pageController.jumpToPage(index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Jour',
              backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              label: 'Pays',
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.museum),
              label: 'Musee',
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Biblio',
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Visite',
                backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Ouvrage',
                backgroundColor: Colors.blue
            ),
          ],
        ),
      floatingActionButton: Add(_currentIndex),
    );
  }
}
