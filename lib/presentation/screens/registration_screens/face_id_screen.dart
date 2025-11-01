import 'package:docdoc/presentation/screens/home_screens/home_screen.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/txt.dart';

class FaceIdScreen extends StatelessWidget {
  const FaceIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.08,
          size.height * 0.12,
          size.width * 0.08,
          size.width * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Face ID",
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              Txt.faceIdTxt,
              style: TextStyle(
                color: ColorsManager.grey,
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: size.height * 0.120),
            Center(child: SvgPicture.asset("assets/images/faceID.svg")),
            const Spacer(),
            ButtonWidget(text: "Submit", onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
            },)
          ],
        ),
      ),
    );
  }
}