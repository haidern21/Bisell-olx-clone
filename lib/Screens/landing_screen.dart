import 'package:bisell_olx_clone/Screens/HOMEPAGE.dart';
import 'package:bisell_olx_clone/Screens/account_screen.dart';
import 'package:bisell_olx_clone/Screens/all_chat_screen.dart';
import 'package:bisell_olx_clone/Screens/favourite_screen.dart';
import 'package:bisell_olx_clone/Screens/Sell/sell_categories_screen.dart';
import 'package:flutter/material.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int pageIndex = 0;

  final pages = [
    const HomePage(),
    const AllChatsScreen(),
    const SellCategoriesScreen(),
    const FavouriteScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[pageIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            pageIndex=index;
          });
        },
        currentIndex: pageIndex,
        items: const [
           BottomNavigationBarItem(
            icon:  Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
           BottomNavigationBarItem(
            icon:  Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
           BottomNavigationBarItem(
            icon:  Icon(Icons.add),
            label: 'Sell',
          ),
           BottomNavigationBarItem(
            icon:  Icon(Icons.favorite),
            label: 'Favourites',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          )
        ],
      ),
    );
  }
}
