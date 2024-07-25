import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<String> _imageAssets = [
    'images/mobil1.jpeg',
    'images/mobile2.jpeg',
    'images/mobile3.jpeg',
    'images/mobile4.webp',
  ];

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return _homeScreen();
      case 1:
        return Center(child: Text('Order Screen'));
      case 2:
        return Center(child: Text('Profile Screen'));
      default:
        return Center(child: Text('Home Screen'));
    }
  }

  Widget _homeScreen() {
    return ListView(
      children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Popular Product",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _buildImageContainer(height: 150),
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Featured Product",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _buildImageContainer(height: 150),
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Product",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        _buildImageGrid(),
      ],
    );
  }

  Widget _buildImageContainer({required double height}) {
    return Container(
      height: height,
      margin: EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _imageAssets.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(_imageAssets[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageGrid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _imageAssets.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(_imageAssets[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.pushReplacementNamed(context, '/signin');
  }

  void _checkUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }
}
