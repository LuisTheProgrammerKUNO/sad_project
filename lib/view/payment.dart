import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Payment',
            style:
                GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _builPayment(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _builPayment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Card(
              elevation: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const Image(image: AssetImage('images/gcash.jpg'),
                fit: BoxFit.cover,
                width: 300,
                height: 380,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('Gcash', style: GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.w600),),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 50,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Transactioin No',
                hintText: 'Please enter the transaction no',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                List<String> words = value.trim().split(' ');
                if (words.length < 2) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
            onPressed: () {},
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
