import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sad_project/controller/product_list.dart';
import 'package:sad_project/view/service_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = 'hair';

  void updateCategory(String newCategory) {
    setState(() {
      category = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f6),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: searchbar(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
                child: Text(
                  'Discover',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              _buildCategoryButtons(),
              const SizedBox(height: 30),
              categoryState(context, category),
              SizedBox(height: 600, child: _buildPopularSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Welcome, User",
            style: GoogleFonts.roboto(
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.notifications_none,
                  size: 24.0,
                  color: Color(0xFF7440F8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchbar() {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xfff8f9fa),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xff8c939a), size: 30),
          const SizedBox(width: 10),
          const Flexible(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(height: 25, width: 1.5, color: Colors.grey),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons() {
    final categories = ['hair', 'nail', 'skin', 'makeup'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((cat) {
          bool isActive = category == cat; // Check if this category is active
          return MouseRegion(
            child: SizedBox(
              width: 80,
              height: 50,
              child: Card(
                elevation: isActive ? 1 : 0,
                color: isActive
                    ? const Color.fromARGB(199, 116, 64, 248)
                    : const Color(0xffebebeb),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: isActive ? Colors.transparent : Colors.white,
                  ),
                ),
                child: TextButton(
                  onPressed: () => updateCategory(cat),
                  child: Text(
                    cat[0].toUpperCase() + cat.substring(1),
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: isActive
                          ? Colors.white
                          : const Color(0xFF000000), // Purple for inactive
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.w500, // Bold for active
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget categoryState(BuildContext context, String category) {
    if (category == 'hair') {
      return _buildCategoryView(
          context, 'HairForYou', hairForyouListItem, hairServiceList);
    } else if (category == 'nail') {
      return _buildCategoryView(
          context, 'NailForYou', nailForyouListItem, nailProductList);
    } else if (category == 'skin') {
      return _buildCategoryView(
          context, 'SkinForYou', skinForyouListItem, skinProductList);
    } else if (category == 'makeup') {
      return _buildCategoryView(
          context, 'SkinForYou', makeupForyouListItem, makeupProductList);
    } else {
      return _buildCategoryView(
          context, null, hairForyouListItem, hairServiceList);
    }
  }

  Widget _buildPopularSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.fromLTRB(10, 1, 10, 0),
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 5,
            childAspectRatio: 0.72,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) {
              return popularListItem(context, index);
            }),
          ),
        ),
      ],
    );
  }
}

Widget _buildCategoryView(BuildContext context, String? route,
    Widget Function(BuildContext, int) itemBuilder, List<dynamic> itemList) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/Book');
    },
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "For You",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                if (route != null)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/$route');
                    },
                    child: const Text(
                      "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7440F8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 265,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: itemBuilder,
            itemCount: 2,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    ),
  );
}
