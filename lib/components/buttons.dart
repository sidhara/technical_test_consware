import 'package:flutter/material.dart';

class LargeRectangularButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final String fontFamily;
  final String iconImg;
  final double borderRadius;
  final Function() onTap;
  const LargeRectangularButton({
    Key? key,
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    this.fontFamily = 'null',
    this.iconImg='null',
    required this.borderRadius,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FloatingActionButton.extended(
          heroTag: UniqueKey(),
          onPressed: onTap,
          backgroundColor: backgroundColor,
          icon: iconImg!='null'?Image.asset(iconImg, height: 25,):null,
          label: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontFamily: fontFamily != 'null' ? fontFamily : null
            )
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
    );
  }
}

class TextOnlyButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final Function() onTap;
  const TextOnlyButton(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.color,
      this.fontFamily = 'null',
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: fontFamily != 'null' ? fontFamily : null,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: color),
      ),
    );
  }
}

class DropdownButtonCustom extends StatefulWidget {
  final List items;
  final double width;
  final double height;
  final bool border;
  final Color borderColor;
  const DropdownButtonCustom({super.key, required this.items,
    required this.width, this.borderColor=Colors.grey, this.border=false,
    this.height=58});

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    selectedItem=widget.items[0];
    return SizedBox(
      width: widget.width,
      height: widget.height!=58?widget.height:58,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: widget.border?InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2,color: widget.borderColor)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2,color: widget.borderColor)
          )
        ):null,
        value: selectedItem,
        items: widget.items.map((item)=>DropdownMenuItem<String>(
          value: item,
          child: Text(
            item, 
            style: const TextStyle(
              fontSize: 15
            )
          )
        )).toList(),
        onChanged: (item)=>setState(() {
          selectedItem=item;
          setSelectedItem(item!);
        })
      ),
    );
  }
}
String selectedItem='';
String getSelectedItem(){
  return selectedItem;
}
void setSelectedItem(String item){
  selectedItem=item;
}