import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainButton extends StatelessWidget {
  MainButton({
    this.title = '',
    this.color = Colors.white,
    required this.onPressed,
    this.svgIcon = '',
  });
  final String title;
  final Color color;
  final Function onPressed;
  final String? svgIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        height: 80,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgIcon!.isNotEmpty
                  ? SvgPicture.asset(
                      svgIcon!.isNotEmpty ? 'assets/google-icon.svg' : svgIcon!,
                      width: 30,
                    )
                  : Container(),
              svgIcon!.isNotEmpty ? SizedBox(width: 15) : Container(),
              Text(
                title,
                style: TextStyle(
                  color: color == Colors.white ? Colors.black : Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
