import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime today = DateTime.now();
  void onSelectedDay(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        title: Center(
          child: Text(
            'Date & Time',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCalendar(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildTime('8:00-9:00'),
                _buildTime('9:00-10:00'),
                _buildTime('11:00-12:00'),
                _buildTime('1:00-2:00'),
                _buildTime('2:00-3:00'),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFf6f6f6),
          borderRadius: BorderRadius.circular(30)),
      child: TableCalendar(
          focusedDay: today,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          availableGestures: AvailableGestures.all,
          onDaySelected: onSelectedDay,
          selectedDayPredicate: (day) => isSameDay(day, today),
          firstDay: DateTime.utc(2022, 01, 01),
          lastDay: DateTime.utc(2030, 12, 31)),
    );
  }

  Widget _buildTime(String? time) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF7440f8)),
          borderRadius: BorderRadius.circular(30)),
      child: TextButton(
          onPressed: () {},
          child: Text(
            '$time',
            style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF7440f8)),
          )),
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Payment');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7440F8),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
