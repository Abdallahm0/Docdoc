import 'package:docdoc/presentation/screens/main_screen.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:docdoc/presentation/widgets/profile_widgets/profile_pic.dart';
import 'package:docdoc/presentation/widgets/registration_widgets/text_form_field_widget.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/txt.dart';
import '../../../data/user_model.dart';
import '../../../logic/user/post/cubit.dart';
import '../../../logic/user/post/state.dart';
// import '../../widgets/button_widget.dart';
// import '../../widgets/profile_widgets/profile_pic.dart';
// import '../../widgets/registration_widgets/text_form_field_widget.dart';
//import '../../widgets/top_bar.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingDialog() {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = UserPostCubit.get(context);

    return BlocListener<UserPostCubit, UserPostState>(
      listener: (context, state) {
        if (state is UserPostLoading) {
          _showLoadingDialog();
        } else if (state is UserPostSuccess || state is UserPostError) {
          _hideLoadingDialog();
        }

        if (state is UserPostSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User created successfully!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
          );
        } else if (state is UserPostError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.message}")),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.04,
            size.height * 0.08,
            size.width * 0.04,
            size.height * 0.04,
          ),
          child: Column(
            children: [
              const TopBar(text: "Personal information"),
              SizedBox(height: size.height * 0.02),
              const ProfilePic(),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      TextFormFieldWidget(
                        hintText: "Name",
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
                        hintText: "Phone",
                        controller: phoneController,
                        keyType: TextInputType.phone,
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormFieldWidget(
                        hintText: "Gender",
                        controller: genderController,
                        keyType: TextInputType.text,
                      ),
                      SizedBox(height: size.height * 0.04),
                      Text(
                        Txt.perInfoTxt,
                        style: TextStyle(
                          color: ColorsManager.grey,
                          fontSize: size.width * 0.035,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      ButtonWidget(
                        text: "Save",
                        onTap: () {
                          if (nameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              genderController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text("Please fill all required fields")),
                            );
                            return;
                          }

                          final user = UserModel(
                            id: 0,
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                            gender: genderController.text.trim(),
                          );

                          cubit.createUser(user);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
