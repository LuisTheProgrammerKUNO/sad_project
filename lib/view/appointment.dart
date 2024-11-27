import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int current = 0;
  List<String> tabs = [
    "Request",
    "Pending",
    "Completed",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "BeautyBar",
            style:
                GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: _buildTab(),
    );
  }

  Widget _buildTab() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            width: size.width,
            height: size.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.04,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: tabs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: index == 0 ? 10 : 23, top: 7),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: Text(
                                tabs[index],
                                style: GoogleFonts.roboto(
                                  fontSize: current == index ? 16 : 14,
                                  fontWeight: current == index
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.3),
            child: Text(
              "${tabs[current]} Tab Content",
              style: GoogleFonts.ubuntu(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
