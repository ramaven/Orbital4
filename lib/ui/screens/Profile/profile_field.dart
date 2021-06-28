import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  //final Function onChangeMethod;

  const ProfileField({
    Key key,
    this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
