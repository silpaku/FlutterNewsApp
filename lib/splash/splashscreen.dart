import 'package:flutter/material.dart';
import 'package:inshorts/mainscreens/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    home();
  }
  
  Widget build(BuildContext context) {
    return  Scaffold(
      
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/splah.jpeg',height: 300,width: 300,),
          ),
        ],
      ),
    );
  }

  Future home() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
}

}