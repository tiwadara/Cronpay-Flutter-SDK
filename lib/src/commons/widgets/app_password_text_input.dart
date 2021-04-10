import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasswordTextInput extends StatefulWidget {
  final Function validator;
  final Function onChanged;
  final String helperText;
  final TextStyle style;
  final String label;
  final Iterable<String>  autofillHints;

  const PasswordTextInput(
      {Key key, this.validator, this.onChanged, this.autofillHints, this.helperText, this.label, this. style})
      : super(key: key);

  @override
  _PasswordTextInputState createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText: _obscureText,
        autofillHints: widget.autofillHints,
        style : widget.style,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: TextStyle(color: AppColors.grey),
            hintText: "Your secret access key",
            helperText: widget.helperText,
            labelText: widget.label ?? 'PASSWORD',
            suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.accentDark,
                ),
                onPressed: _toggleObscureText)));
  }
}
