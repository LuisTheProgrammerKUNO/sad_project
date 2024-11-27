import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sad_project/view/Payment.dart';
import 'package:sad_project/view/Service.dart';
import 'package:sad_project/view/account.dart';
import 'package:sad_project/view/booking.dart';
import 'package:sad_project/view/home.dart';
import 'package:sad_project/view/login.dart';
import 'package:sad_project/view/on_board_screen.dart';
import 'package:sad_project/view/register.dart';
import 'package:sad_project/view/appointment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: false,
    );

    return MaterialApp(
      title: 'Secret Salon App',
      initialRoute: '/OnBoard',
      routes: {
        '/OnBoard': (context) => const SafeArea(child: OnBoardScreen()),
        '/Login': (context) => const SafeArea(child: LoginScreen()),
        '/Register': (context) => const SafeArea(child: RegisterScreen()),
        '/Main': (context) => const SafeArea(child: MainWidget()),
        '/Home': (context) => const SafeArea(child: HomeScreen()),
        '/Services': (context) => const SafeArea(child: ServivesScreen()),
        '/Book': (context) => const SafeArea(child: BookingScreen()),
        '/Payment': (context) => const SafeArea(child: PaymentScreen()),
        '/Appointment': (context) => const SafeArea(child: AppointmentScreen()),
        '/Account': (context) => const SafeArea(child: AccountScreen()),
      },
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int _currentIndex = 0;

  final tabs = [
    const SafeArea(child: HomeScreen()),
    const SafeArea(child: ServivesScreen()),
    const SafeArea(child: AppointmentScreen()),
    const SafeArea(child: AccountScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 116, 64, 248),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 202, 201, 201),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_cut),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appoinment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
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
}
