// import 'package:docdoc/presentation/screens/registration_screens/forgot_pss_screen.dart';
import 'package:docdoc/presentation/screens/registration_screens/forgot_pss_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/helpers/shared_prefs_helper.dart';
import '../../../core/utils/colors.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final remember = await SharedPrefsHelper().getRememberMe();
    setState(() {
      isRememberMe = remember;
    });
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              side: BorderSide(width: 2, color: ColorsManager.lightGrey),
              activeColor: ColorsManager.blue,
              value: isRememberMe,
              onChanged: (value) async {
                setState(() {
                  isRememberMe = value!;
                });
                await SharedPrefsHelper().saveRememberMe(isRememberMe);
              },

            ),
            Text(
              "Remember Me",
              style: TextStyle(
                color: ColorsManager.lightGrey,
                fontSize: size.width * 0.03,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPssScreen()));
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: ColorsManager.blue,
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.03,
            ),
          ),
        ),
      ],
    );
  }
}