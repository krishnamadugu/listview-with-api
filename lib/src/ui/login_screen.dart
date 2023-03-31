import 'package:demo/src/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<FormState> formkey = GlobalKey<FormState>();
String snack_bar = "";
late SharedPreferences localStorage;
TextEditingController emailController = new TextEditingController();
TextEditingController pwdController = new TextEditingController();

final snack = SnackBar(content: Text(snack_bar));
bool vis = true;

Icon visoff = Icon(
  Icons.visibility_off_outlined,
  color: Colors.black,
);
Icon vison = Icon(
  Icons.visibility_outlined,
  color: Colors.black,
);
late Icon passicon = visoff;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // getImage('nabnsm'),
                Image.asset(
                  "images/top_image.png",
                  fit: BoxFit.cover,
                  scale: 2,
                ),
                const SizedBox(
                  height: 38.0,
                ),
                Text(
                  "Welcome",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Color(0xff242424),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // style: TextStyle(
                  //   color: Color(0xff242424),
                  //   fontSize: 24.0,
                  // ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  "Please enter your account details",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Color(0xff95919B),
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Invalid Email';
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27.0),
                      borderSide: const BorderSide(
                        color: Color(0xffDDD9E3),
                      ),
                    ),
                    labelText: "Email",
                    hintText: "Enter Valid Email",
                    hintStyle: GoogleFonts.sourceSansPro(
                      textStyle: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xff95919B),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TextFormField(
                  controller: pwdController,
                  obscureText: vis,
                  validator: (value) {
                    var password = value ?? "";
                    // bool hasUppercase =
                    //     password.contains(new RegExp(r'^[A-Z]'));
                    // bool hasDigits = password.contains(new RegExp(r'^[0-9]'));
                    // bool hasLowercase =
                    //     password.contains(new RegExp(r'^[a-z]'));
                    // bool hasSpecialCharacters = password
                    //     .contains(new RegExp(r'^[!@#$%^&*(),.?":{}|<>]'));

                    if (password.isEmpty) {
                      return "password can't be empty";
                    } else if (password.length < 6) {
                      return "password length should be greater than 6";
                    }
                    // else if ((hasUppercase &&
                    //         hasDigits &&
                    //         hasLowercase &&
                    //         hasSpecialCharacters) ==
                    //     false) {
                    //   return "Enter valid password";
                    // }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: const BorderSide(
                          color: Color(0xffDDD9E3),
                        ),
                      ),
                      labelText: "Password",
                      hintText: "Enter your Secure Password",
                      hintStyle: GoogleFonts.sourceSansPro(
                        textStyle: const TextStyle(
                          fontSize: 15.0,
                          color: Color(0xff95919B),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (passicon == visoff) {
                              vis = false;
                              passicon = vison;
                            } else {
                              vis = true;
                              passicon = visoff;
                            }
                          });
                        },
                        icon: passicon,
                      )),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Text("Forgot Password?",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 13.0,
                        color: Color(0xffFF0037),
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                const SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 55.0,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {}
                      save();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return HomePage(
                          email: '${localStorage.get('email')}',
                          pwd: '${localStorage.get('password')}',
                        );
                      }));
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return const Color(0xffFF0037);
                        },
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.sourceSansPro(
                        textStyle: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      WidgetSpan(
                        child: SizedBox(width: 5.0),
                      ),
                      TextSpan(
                        text: "RegisterNow",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffFF0037),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

save() async {
  await LoginScreen.init();

  localStorage.setString('email', emailController.text.toString());
  localStorage.setString('password', pwdController.text.toString());
}

//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
