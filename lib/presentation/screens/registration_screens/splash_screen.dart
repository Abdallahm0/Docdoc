// import 'package:docdoc/core/const/images_paths.dart';
// import 'package:docdoc/core/utils/page_transition.dart';
// import 'package:docdoc/presentation/screens/registration_screens/started_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'dart:async';

// import 'package:flutter_svg/flutter_svg.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//         context,
//         createFadeSlideRoute(StartedScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Center(child: Image.asset(ImagesPaths.backSplash)),
//           Align(
//             alignment: Alignment.center,
//             child: SvgPicture.asset(
//               ImagesPaths.docdocLogo,
//             ).animate().fadeIn(duration: 3.seconds).moveX(duration: 3.seconds),
//           ),
//         ],
//       ),
//     );
//   }
// }
