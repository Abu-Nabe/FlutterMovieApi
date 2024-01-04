import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool usernameErrorVisible = false;
  bool pinErrorVisible = false;
  String errorText = '';

  TextEditingController usernameController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: buildLoginDesign(),
      ),
    );
  }

  Widget buildLoginDesign() {
    return Container(
      color: Color(0xFFE30B5C),
      child: Center(
        child: buildHomeContent(),
      ),
    );
  }

  Widget buildHomeContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.movie,
          size: 100.0,
          color: Colors.white,
        ),
        SizedBox(height: 16.0),
        Text(
          'Movie Project',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 16.0),
        buildTextField(),
        SizedBox(height: 16.0),
        buildLoginButton(),
        SizedBox(height: 16.0),
        Text(
          errorText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget buildTextField() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0xFFE3E3E3), width: 2.0),
            ),
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onChanged: (value) {
                // Clear error text when the text changes
                setState(() {
                  errorText = '';
                });
              },
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Color(0xFFE3E3E3), width: 2.0),
            ),
            child: TextFormField(
              controller: pinController,
              decoration: InputDecoration(
                hintText: 'Pin',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              obscureText: true,
              onChanged: (value) {
                // Clear error text when the text changes
                setState(() {
                  errorText = '';
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (usernameController.text.isEmpty || pinController.text.isEmpty) {
            errorText = "Username or Pin is empty";
          } else {
            Navigator.pushNamed(context, "/main");
          }
        });
      },
      child: Text('Login'),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(200.0, 50.0)),
        padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
        backgroundColor: MaterialStateProperty.all(Color(0xFFE30B5C)),
        side: MaterialStateProperty.all(
            BorderSide(color: Colors.grey[600]!, width: 1.0)),
      ),
    );
  }
}
