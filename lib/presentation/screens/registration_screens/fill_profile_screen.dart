import 'package:docdoc/presentation/widgets/profile_widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/txt.dart';
import '../../widgets/registration_widgets/phone_num_field_widget.dart';
import '../../widgets/registration_widgets/text_form_field_widget.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

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
              "Fill Your Profile",
              style: TextStyle(
                fontSize: size.width * 0.06,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              Txt.profileTxt,
              style: TextStyle(
                color: ColorsManager.grey,
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: size.height * 0.045),
            ProfilePicWidget(),
            SizedBox(height: size.height * 0.04),
            TextFormFieldWidget(
              hintText: "Full Name",
              controller: nameController,
              keyType: TextInputType.name,
            ),
            SizedBox(height: size.height * 0.02),
            TextFormFieldWidget(
              hintText: "Email",
              controller: emailController,
              keyType: TextInputType.emailAddress,
            ),
            SizedBox(height: size.height * 0.02),
            TextFormFieldWidget(
              hintText: "Birthday",
              controller: birthdayController,
              keyType: TextInputType.emailAddress,
            ),
            SizedBox(height: size.height * 0.02),
            PhoneNumFieldWidget(),

            Spacer(),
            SizedBox(
              height: size.height * 0.065,
              width: double.infinity,
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorsManager.blue,
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
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