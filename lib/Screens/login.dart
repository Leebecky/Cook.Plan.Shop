import 'package:cook_plan_shop/Custom_Widget/custom_alert_dialog.dart';
import 'package:cook_plan_shop/Custom_Widget/custom_buttons.dart';
import 'package:cook_plan_shop/Custom_Widget/custom_text_field.dart';
import 'package:cook_plan_shop/navigations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscured, isAuthenticating;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void initState() {
    isObscured = true;
    isAuthenticating = false;
    super.initState();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

//^ Login Page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                //~ Logo & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Image(
                        image: AssetImage("assets/logo-recipe-book.png"),
                        height: 50,
                      ),
                    ),
                    Text(
                      "Cook.Plan.Shop",
                      textScaleFactor: 2.2,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5.5,
                ),
                //~ Email
                CustomTextField(
                  controller: emailCtrl,
                  labelText: "Email",
                  borderColor: Colors.white,
                ),
                SizedBox(
                  height: 25,
                ),
                //~ Password
                TextField(
                  obscureText: isObscured,
                  controller: passwordCtrl,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: Colors.white,
                        icon: (isObscured)
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () => setState(() {
                          isObscured = !isObscured;
                        }),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(height: 35),
                //~ Login button / Loading animation when authenticating
                (isAuthenticating)
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: SpinKitThreeBounce(
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                      )
                    : CustomTextButton(
                        label: "Login",
                        width: 100,
                        borderRadius: 50,
                        onPressed: () => signIn(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//? Authenticates the user
  void signIn() async {
    setState(() {
      isAuthenticating = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtrl.text, password: passwordCtrl.text);

      //^ Login is Successful
      Get.offAll(() => Navigations());
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        openDialog(context,
            dialogType: CustomAlertDialog(
                titleText: "Invalid Email",
                contentText: "Please check your email"));
      }
      if (e.code == "wrong-password") {
        openDialog(context,
            dialogType: CustomAlertDialog(
                titleText: "Incorrect Password",
                contentText: "Your password was incorrect! Please try again."));
      }

      if (e.code == "user-not-found") {
        //! Redirect to Registration
        openDialog(context,
            dialogType: CustomAlertDialog(
                titleText: "User Not Found",
                contentText: "No account? Join us today!"));
      }
    } finally {
      setState(() {
        isAuthenticating = false;
      });
    }
  }
}
