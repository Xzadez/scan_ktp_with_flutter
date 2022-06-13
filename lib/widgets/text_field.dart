import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLines;

  const TextFieldCustom({
    Key? key,
    this.controller,
    this.title,
    this.hintText,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Text(
              title ?? '',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFE9E9E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: TextFormField(
                maxLines: maxLines,
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                textInputAction: textInputAction,
                obscureText: obscureText,
                keyboardType: keyboardType,
                validator: validator,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF504F5E),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
