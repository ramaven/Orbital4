import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationSettingsOption extends StatelessWidget {
  final String label;
  final bool value;
  final Function onChangeMethod;

  const NotificationSettingsOption(
      {Key key, this.label, this.value, this.onChangeMethod})
      : super(key: key);

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
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),
          Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: Colors.blue,
                trackColor: Colors.grey,
                value: value,
                onChanged: (bool newValue) {
                  onChangeMethod(newValue);
                },
              ))
        ],
      ),
    );
  }
}
