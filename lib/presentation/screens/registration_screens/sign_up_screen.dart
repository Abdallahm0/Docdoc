import 'package:docdoc/logic/sign_up/cubit.dart';
import 'package:docdoc/logic/sign_up/state.dart';
import 'package:docdoc/presentation/screens/main_screen.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:docdoc/presentation/widgets/registration_widgets/have_acc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/txt.dart';
import '../../widgets/registration_widgets/check_box_widget.dart';
import '../../widgets/registration_widgets/divider_widget.dart';
import '../../widgets/registration_widgets/sign_in_options_widget.dart';
import '../../widgets/registration_widgets/text_form_field_widget.dart';
import '../../widgets/registration_widgets/text_span_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          } else if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.08,
                size.height * 0.08,
                size.width * 0.08,
                size.height * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.blue,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      Txt.startedTxt2,
                      style: TextStyle(
                        color: ColorsManager.grey,
                        fontSize: size.width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: size.height * 0.045),
                    TextFormFieldWidget(
                      hintText: "Email",
                      controller: emailController,
                      keyType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormFieldWidget(
                      hintText: "Name",
                      controller: nameController,
                      keyType: TextInputType.name,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormFieldWidget(
                      hintText: "Password",
                      obscureText: _isObscure,
                      controller: passController,
                      keyType: TextInputType.visiblePassword,
                      suffIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: ColorsManager.lightGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormFieldWidget(
                      hintText: "Confirm Password",
                      obscureText: _isObscure,
                      controller: passConfirmationController,
                      keyType: TextInputType.visiblePassword,
                      suffIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: ColorsManager.lightGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormFieldWidget(
                      hintText: "phoneNumber",
                      controller: phoneController,
                      keyType: TextInputType.phone,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormFieldWidget(
                      hintText: "gender",
                      controller: genderController,
                      keyType: TextInputType.number,
                    ),

                    SizedBox(height: size.height * 0.03),
                    CheckBoxWidget(),
                    SizedBox(height: size.height * 0.04),

                      (state is SignUpLoadingState) ? Center(child: CircularProgressIndicator(color: ColorsManager.blue,)) : ButtonWidget(
                      text: "Create Account",
                      onTap: () {
                        context.read<SignUpCubit>().signUp(email: emailController.text,
                            password: passController.text,
                            password_confirmation: passConfirmationController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            gender: genderController.text);
                      },
                    ),
                    SizedBox(height: size.height * 0.06),
                    DividerWidget(),
                    SizedBox(height: size.height * 0.04),
                    SignInOptionsWidget(),
                    SizedBox(height: size.height * 0.04),
                    TextSpanWidget(),
                    SizedBox(height: size.height * 0.03),
                    HaveAccWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}