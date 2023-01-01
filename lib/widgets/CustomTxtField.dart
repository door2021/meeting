import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTxtField extends StatelessWidget {
  CustomTxtField({Key? key, this.hint, this.txt}) : super(key: key);

  final String? hint;
  final TextEditingController? txt;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txt,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

class CustomTxtField2 extends StatefulWidget {
  CustomTxtField2({Key? key, this.hint, this.txt, this.isSecure = false})
      : super(key: key);

  final String? hint;
  bool isSecure;
  final TextEditingController? txt;

  @override
  State<CustomTxtField2> createState() => _CustomTxtField2State();
}

class _CustomTxtField2State extends State<CustomTxtField2> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isSecure,
      keyboardType: TextInputType.text,
      controller: widget.txt,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        filled: true,
        fillColor: Colors.white,
        // Here is key idea
        suffixIcon: IconButton(
          icon: Icon(
            widget.isSecure ? Icons.visibility_off : Icons.visibility,
            size: 18,
            color: Color.fromARGB(255, 34, 3, 68),
          ),
          onPressed: () {
            setState(() {
              widget.isSecure = !widget.isSecure;
            });
          },
        ),
      ),
    );
  }
}

class CustomTxtField3 extends StatelessWidget {
  CustomTxtField3(
      {Key? key,
      this.label,
      this.hint,
      this.txt,
      this.suffixIcon,
      this.enabled = true})
      : super(key: key);

  String? label, hint;
  TextEditingController? txt;
  IconData? suffixIcon;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(2, 13, 40, 1)))),
        Container(
            margin: EdgeInsets.only(top: 5),
            height: 55,
            child: TextField(
              controller: txt,
              style: GoogleFonts.poppins(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  enabled: enabled,
                  suffixIcon: suffixIcon == null
                      ? null
                      : Icon(
                          suffixIcon,
                          color: Color.fromRGBO(173, 173, 173, 1),
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintText: hint!,
                  hintStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  filled: true,
                  fillColor: Colors.white),
            ))
      ],
    );
  }
}
