import 'package:chat_app/constant.dart';
import 'package:chat_app/presentation/bloc/auth/auth_bloc_bloc.dart';
import 'package:chat_app/presentation/bloc/auth/auth_bloc_event.dart';
import 'package:chat_app/presentation/bloc/auth/auth_bloc_state.dart';
import 'package:chat_app/presentation/screen/forgot_password_page.dart';
import 'package:chat_app/presentation/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        email: _emailController.text, 
        name: _nameController.text, 
        password: _passwordController.text
      ),

    );

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
       elevation: 2.0,
       title: const Text("Sign Up", style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        )
       ),
       shadowColor: Colors.green,
       flexibleSpace: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
             colors: [Constants.primaryColor, Colors.greenAccent],
                begin: Alignment.topLeft,
              end: Alignment.topRight
          )         
        ),
       ),
      ),
      body: ListView(
        children: [
          Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        alignment: Alignment.center,
        child: Column(        
          children: [
            _buildTextInput('Email Address', _emailController),
            const SizedBox(height: 20,),
            _buildTextInput('Name', _nameController),
            const SizedBox(height: 20,),
            _buildTextInput('Password', _passwordController),
            const SizedBox(height: 20,),
            _buildTextInput('Confirm Password', _confirmPasswordController),
            BlocConsumer<AuthBloc, AuthState>(
              builder: (context, state){
                if (state is AuthLoading) {
                 return const Center(child: CircularProgressIndicator(),);
                } 
                return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                        color: Constants.primaryColor
                      ),
                      width: 400,
                      child: _buildButtonSignUp(_onRegister)
                      );
              }, 
              listener: (context, state){
                if (state is AuthSuccess) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                } else if (state is AuthFailure){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error))
                  );
                }
              }
            ),
            const SizedBox(height: 50,),
            

          ],
        ),
      ),

        ],
      )
   );
  }


  Widget _buildTextInput(String hint, TextEditingController controller, {bool isPassword = false}){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder()
      ),
      obscureText: isPassword,
    );

  }

  Widget _buildButtonSignUp(VoidCallback onPressed){
     return TextButton(
        onPressed: onPressed,
        child: const Text(
            'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )
        )
    );
  }


}



