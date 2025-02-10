import 'package:chat_app/constant.dart';
import 'package:chat_app/screen/forgot_password_page.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome Back!', style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),

            const Text(Constants.descripLogin),

            const Padding(padding: EdgeInsets.only(top: 30)),
            _UsernameInput(),

            const Padding(padding: EdgeInsets.only(top: 20)),
            _PasswordInput(),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Transform.translate(
                    offset: Offset(-25, 0),
                    child: _CheckBoxRememberMe(),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Transform.translate(
                      offset: Offset(-40, 0),
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

            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                color: Constants.primaryColor
              ),
              width: 400,
              child: _ButtonLogin()
            ),

            const Padding(padding: EdgeInsets.only(top: 100)),
            const DashedLineWithText(text: "OR CONTINUE WITH")

          ],
        ),
      ),
    );
  }
}

// Extra widget
class _UsernameInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Email Address',
        border: OutlineInputBorder()

      ),
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput>{
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Password',
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

}

class _CheckBoxRememberMe extends StatefulWidget {

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBoxRememberMe>{
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
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
}

class _ButtonLogin extends StatefulWidget{
  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<_ButtonLogin>{
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          setState(() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
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

}

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


