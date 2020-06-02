import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIcon extends StatelessWidget {

  final String iconSrc;
  final Function press;

  const SocialIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
          shape: BoxShape.circle,
          color: Theme.of(context).accentColor.withOpacity(0.2),
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
