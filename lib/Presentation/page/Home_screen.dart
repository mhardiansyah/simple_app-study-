import 'package:app_simple/core/Routing/App_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_simple/service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              accountName: Text(
                "Muhammad Hardiansyah Setiadi",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "abroqy@gmail.com",
                style: GoogleFonts.poppins(),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "MH",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () {
                AuthService().logout(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFf2f2f2),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/download.jpg'),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          "HI ",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "What do you want ?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
                controller: searchQueryController,
                decoration: InputDecoration(
                  hintText: "Search destination",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  // if (value.isNotEmpty) {
                  //   context
                  //       .goNamed(Routes.search, extra: {'searchQuery': value});
                  // }
                  // context.goNamed(Routes.search, extra: value),
                }),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                InkWell(
                    onTap: () => context.goNamed(Routes.menu),
                    child: _buildMenuItem(Icons.restaurant, "Restaurant")),
                _buildMenuItem(Icons.shopping_cart, "Penjualan"),
                _buildMenuItem(Icons.bar_chart, "Laporan"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItem(IconData icon, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue[100],
        child: Icon(icon, size: 30, color: Colors.blue),
      ),
      SizedBox(height: 8),
      Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
