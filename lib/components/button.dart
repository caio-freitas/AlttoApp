import 'package:flutter/material.dart';
import 'package:altto_app/scripts/basicfunctions.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final String imgSrc;

  const BasicButton({
    Key key,
    this.text,
    this.onPressed,
    this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getPass();
    getUserName();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                style: BorderStyle.solid,
                color: Theme.of(context).splashColor,
                width: 2)),
        onPressed: onPressed,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 100, 0, 0),
                  child: Image.asset(
                    imgSrc,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              flex: 4,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 1,
              ),
            ),
            Expanded(
              child: FittedBox(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 4),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: 'Marvel',
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              flex: 2,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}