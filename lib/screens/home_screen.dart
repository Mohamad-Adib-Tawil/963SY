import 'package:flutter/material.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const RTLText(
          text: 'Tourism App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildExploreTab();
      case 2:
        return _buildFavoritesTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return const Center(
      child: RTLText(
        text: 'Home Tab',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildExploreTab() {
    return const Center(
      child: RTLText(
        text: 'Explore Tab',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return const Center(
      child: RTLText(
        text: 'Favorites Tab',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildProfileTab() {
    return const Center(
      child: RTLText(
        text: 'Profile Tab',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class DirectionalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isArabic;

  const DirectionalText({
    super.key,
    required this.text,
    this.style,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return isArabic
        ? RTLText(text: text, style: style)
        : Text(text, style: style);
  }
}
