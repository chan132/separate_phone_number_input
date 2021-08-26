import 'package:flutter/material.dart';
import 'package:separate_phone_number_input/separate_phone_number_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test Input Demo",
      routes: {
        "/": (context) => TestPhoneNumInputPage(),
      },
    );
  }
}

class TestPhoneNumInputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestPhoneNumInputPageState();
}

class _TestPhoneNumInputPageState extends State<TestPhoneNumInputPage> {
  TextEditingController _phoneController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test phone number input",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: PhoneNumInput(
          helperText:
              "unregistered phone numbers automatically create accounts",
          // helperText:
          //     "the phone number entered was incorrect",
          controller: _phoneController,
          focusNode: _focusNode,
          isShowHelperText: true,
          // isShowErrorState: true,
          // helperTextSyncErrorState: true,
          onNumInputComplete: (result) => print("the phone number is entered"),
          onEditingComplete: () => print("complete editing"),
        ),
      ),
    );
  }
}
