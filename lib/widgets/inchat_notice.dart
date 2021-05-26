import 'package:flutter/material.dart';

class InchatNotice extends StatelessWidget {
  const InchatNotice(
      {Key? key, this.label = "Hey there", this.icon, this.onClick})
      : super(key: key);

  final IconData? icon;
  final String label;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onClick,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    this.icon,
                    size: 16,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  Container(
                      width: this.icon != null ? 20 : 0,
                      height: 5,
                      color: Colors.transparent),
                  Text(
                    this.label,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
