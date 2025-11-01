import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/core/utils/txt.dart';
import 'package:docdoc/logic/login/cubit.dart';
import 'package:docdoc/logic/login/state.dart';
import 'package:docdoc/presentation/screens/main_screen.dart';
import 'package:docdoc/presentation/screens/registration_screens/sign_up_screen.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/registration_widgets/check_box_widget.dart';
import '../../widgets/registration_widgets/divider_widget.dart';
import '../../widgets/registration_widgets/sign_in_options_widget.dart';
import '../../widgets/registration_widgets/text_form_field_widget.dart';
import '../../widgets/registration_widgets/text_span_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscure = true;
  bool isRememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginsStates>(
        listener: (context, state) {
          if(state is LoginsSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
                (route)=> false,
            );
          } else if (state is LoginsErrorState) {
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
                size.height * 0.12,
                size.width * 0.08,
                0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.blue,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      Txt.startedTxt,
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
                    SizedBox(height: size.height * 0.03),
                    CheckBoxWidget(),
                    SizedBox(height: size.height * 0.04),
                    (state is LoginsLoadingState)?Center(child: CircularProgressIndicator(color: ColorsManager.blue,)) :
                    ButtonWidget( text: "Login", onTap: () {
                      context.read<LoginCubit>().login(
                        email: emailController.text,
                        password: passController.text,
                      );
                    },),
                    SizedBox(height: size.height * 0.06),
                    DividerWidget(),
                    SizedBox(height: size.height * 0.04),
                    SignInOptionsWidget(),
                    SizedBox(height: size.height * 0.04),
                    TextSpanWidget(),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account yet?",
                          style: TextStyle(
                            fontSize: size.width * 0.028,
                            fontWeight: FontWeight.w400,
                            color: ColorsManager.black,
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> SignUpScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: size.width * 0.028,
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
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