import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({Key? key, this.label, this.hint, this.value, this.items})
      : super(key: key);

  String? label;
  String? hint;
  var value;
  List? items;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label!,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color.fromRGBO(2, 13, 40, 1)))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              onChanged: (val) {
                setState(() {
                  widget.value = val;
                });
              },
              value: widget.value,
              icon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Color.fromRGBO(173, 173, 173, 1),
              ),
              hint: Text(widget.hint!,
                  style: TextStyle(
                    color: Color.fromRGBO(173, 173, 173, 1),
                  )),
              items: widget.items!
                  .map((i) => DropdownMenuItem(
                      value: i,
                      child: Text(
                        i,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      )))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
