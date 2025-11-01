import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/txt.dart';
import '../../widgets/registration_widgets/text_form_field_widget.dart';

class ForgotPssScreen extends StatefulWidget {
  const ForgotPssScreen({super.key});

  @override
  State<ForgotPssScreen> createState() => _ForgotPssScreenState();
}

class _ForgotPssScreenState extends State<ForgotPssScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.08,
          size.height * 0.06,
          size.width * 0.08,
          size.width * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(text: "Forgot Password"),
            SizedBox(height: size.height * 0.01),

            Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              Txt.forgotTxt,
              style: TextStyle(
                color: ColorsManager.grey,
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: size.height * 0.045),
            TextFormFieldWidget(
              hintText: "Email or Phone Number",
              controller: emailController,
              keyType: TextInputType.emailAddress,
            ),
           Spacer(),
            SizedBox(
              height: size.height * 0.065,
              width: double.infinity,
              child: InkWell(
                onTap: (){
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorsManager.blue,
                  ),
                  child: Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}