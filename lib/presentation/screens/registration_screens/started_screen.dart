import 'package:docdoc/core/const/images_paths.dart';
import 'package:docdoc/core/utils/txt.dart';
import 'package:docdoc/presentation/screens/registration_screens/sign_in_screen.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartedScreen extends StatelessWidget {
  const StartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
           padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.3,
              vertical: size.height * 0.07,
            ),
            child: SvgPicture.asset(ImagesPaths.docdocLogo),
          ),

          Positioned(
            top: size.height * 0.12,
           left: 0,
           right: 0,
            child: Image.asset(
              'assets/images/back2x.png',
             height: size.height * 0.6,
            fit: BoxFit.contain,
            ),
          ),

          Positioned(
         top: size.height * 0.2,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/doctor.png',
              height: size.height * 0.55,
              fit: BoxFit.contain,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
    child: Container(
              height: size.height * 0.5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white, Colors.white70, Colors.transparent],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.06,
              0,
              size.width * 0.06,
              size.height * 0.07,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Best Doctor \nAppointment App',
                    style: TextStyle(
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    Txt.doctorTxt,
                    style: TextStyle(
                      fontSize: size.width * 0.027,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                
                ButtonWidget(text: "Get Started",onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> SignInScreen()));
                },),
             ],
            ),
          ),

        ],
      ),
    );
  }
}