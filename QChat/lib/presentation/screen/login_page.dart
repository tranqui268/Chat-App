import 'package:chat_app/constant.dart';
import 'package:chat_app/presentation/screen/forgot_password_page.dart';
import 'package:chat_app/presentation/screen/home_page.dart';
import 'package:chat_app/presentation/screen/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  bool isChecked = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2.0,
        title: const Text("Sign In", style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        )),
        shadowColor: Colors.green,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Constants.primaryColor, Colors.greenAccent],
                begin: Alignment.topLeft,
              end: Alignment.topRight
            )
          ),
        ),
      ),
      body: ListView( 
      children: [ Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Welcome Back!', style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 8,),

            const Text(Constants.descripLogin),

            const SizedBox(height: 16,),
            _buildUsernameInput('Email Address', _emailController),

             const SizedBox(height: 12,),
            _buildPasswordInput('Password', _passwordController),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Transform.translate(
                    offset: const Offset(-25, 0),
                    child: _buildCheckBoxRememberMe(),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Transform.translate(
                      offset:const Offset(-40, 0),
                      child: const Text('Remember me?')
                    )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.topRight,
                    child:  InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
                        },
                        child: const Text('Forgot Password?', style: TextStyle(
                            color: Constants.primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400
                        ),),
                      ))

                )

              ],
            ),

            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                color: Constants.primaryColor
              ),
              width: 400,
              child: _buildButtonLogin()
            ),

            const SizedBox(height: 10),
            Center( 
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                  children: [
                    const TextSpan(text: "Don't have an account?"),
                    TextSpan(
                      text: "Click here to register",
                      style: const TextStyle(color: Constants.primaryColor, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                         ..onTap = (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>  SignUp()));
                        }
                    )

                  ]
                )
              ),
            ),

            const Padding(padding: EdgeInsets.only(top: 80)),
            const DashedLineWithText(text: "OR CONTINUE WITH"),

            const Padding(padding: EdgeInsets.only(top: 40)),
            _buildButtonLoginBase('Sign In With Facebook', 'assets/images/facebook.png',(){}),

            const Padding(padding: EdgeInsets.only(top: 20)),
            _buildButtonLoginBase('Sign In With Google', 'assets/images/google.png', (){})

          ],
        ),
      ),
      ]
      )
    );
  }

  Widget _buildUsernameInput(String hint, TextEditingController controller){
     return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder()

      ),
    );
  }

  Widget _buildPasswordInput(String hint, TextEditingController controller){
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              _isObscure = ! _isObscure;
            });
          },
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off
          ),
        ),
      ),
      obscureText: _isObscure,
    );
  }

  Widget _buildButtonLogin(){
    return TextButton(
        onPressed: (){
          setState(() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
          });
        },
        child: const Text(
            'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )
        )
    );
  }

  Widget _buildCheckBoxRememberMe(){
    return Checkbox(
      value: isChecked,
      onChanged: (bool? newValue){
        setState(() {
          isChecked = newValue ?? false;
        });
      },
      activeColor: Constants.primaryColor,
    );
  }

  Widget _buildButtonLoginBase(String text, String image, VoidCallback onPressed){
    return TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 30, width: 30, child: Image.asset(image,fit: BoxFit.cover,)),
            Expanded(
              flex: 2,
                child: Transform.translate(
                    offset: const Offset(50, 0),
                  child:  Text(text, style: const TextStyle(
                    fontSize: 16,
                  ),),
                )
            )
          ],
        )
    );

  }

}

// Extra widget
class DashedLineWithText extends StatelessWidget {
  final String text;

  const DashedLineWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            endIndent: 10,
            indent: 10,
            // Dấu đứt đoạn
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            thickness: 1,
            endIndent: 10,
            indent: 10,
            height: 1,
          ),
        ),
      ],
    );
  }
}


