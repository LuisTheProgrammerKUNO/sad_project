import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6f6f6),
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFf6f6f6),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        child: Column(
          children: [
            _buildProfile(),
            const SizedBox(
              height: 30,
            ),
            _buildObject(Icons.settings, 'Settings', const Color(0xff2680e6)),

            GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/Book');
                  },
                  child: _buildObject(Icons.calendar_today, 'Booking', const Color(0xff069295)),
                ),


            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Login');
              },
              child: _buildObject(Icons.logout, 'Logout', const Color(0xFF3e7942)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_circle,
            size: 150,
            color: Color.fromARGB(31, 163, 67, 67),
          ),
          Text(
            'User Name',
            style: GoogleFonts.roboto(
                fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _buildObject(IconData icon, String? name, Color iconColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            width: 330,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFececec),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Icon(
                            icon,
                            color: Colors.white,
                          )),
                      Text(
                        '$name',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward)
              ],
            ),
          )
        ],
      ),
    );
  }
}

