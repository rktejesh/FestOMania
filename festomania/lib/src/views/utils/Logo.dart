import 'package:flutter/material.dart';
class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(

          child: Text(
            'FestOMania',
            style: TextStyle(
                fontFamily: 'Forte',
                fontSize: 35,
                color: Colors.white
            ),
          ),
        )
    );
  }
}

class AppLogo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'FestOMania',
          style: TextStyle(
              fontFamily: 'Forte',
              fontSize: 29,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}