import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sad_project/controller/product_list.dart';
import 'package:sad_project/view/service_view.dart';

class ServivesScreen extends StatefulWidget {
  const ServivesScreen({super.key});

  @override
  State<ServivesScreen> createState() => _ServivesScreenState();
}

class _ServivesScreenState extends State<ServivesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf6f6f6),
        elevation: 0,
        leading: null,
        automaticallyImplyLeading: false,
        title: _buildAppBar(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: _builServiceSections('Hair Service', context,
                    hairForyouListItem, hairServiceList),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: _builServiceSections('Nail Service', context,
                    nailForyouListItem, nailProductList),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: _builServiceSections('Skin Service', context,
                    skinForyouListItem, skinProductList),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: _builServiceSections('Makeup Service', context,
                    makeupForyouListItem, makeupProductList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            'Services',
            style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.local_mall),
          ),
        ),
      ],
    );
  }
}

Widget _builServiceSections(String? name, BuildContext context,
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
                  "$name",
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '');
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
            itemCount: itemList.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    ),
  );
}
