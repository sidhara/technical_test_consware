import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  final String text;
  final bool password;
  final bool user;
  final TextEditingController controller;
  final Color color;
  final bool border;
  final Color borderColor;

  const TextFieldCustom({
    Key? key,
    required this.text,
    required this.controller,
    this.password = false,
    this.user = false,
    this.border = false,
    this.borderColor = Colors.grey,
    required this.color,
  }) : super(key: key);

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late bool hidden;

  @override
  void initState() {
    super.initState();
    hidden = widget.password ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: widget.color,
      obscureText: hidden,
      obscuringCharacter: "•",
      controller: widget.controller,
      decoration: InputDecoration(
          focusColor: widget.color,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: widget.border
                ? BorderSide(color: widget.borderColor, width: 2)
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.color, width: 2),
          ),
          border: const OutlineInputBorder(),
          labelText: widget.text,
          prefixIcon: widget.password
              ? const Icon(Icons.lock,color:Colors.grey)
              : widget.user ? const Icon(Icons.person,color:Colors.grey):null,
          suffixIcon: widget.password
              ? IconButton(
                  color: widget.color,
                  icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                )
              : null),
    );
  }
}
