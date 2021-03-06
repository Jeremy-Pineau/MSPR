import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Licence extends StatefulWidget {
  @override
  _Licence createState() => _Licence();
}

class _Licence extends State<Licence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body:
        Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15.0),
                  child:
                  RichText(
                    text: TextSpan(
                      text: "Licence",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 17.0),
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              Padding(padding: EdgeInsets.all(15.0),
              child:
                RichText(
                  text: TextSpan(
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut dapibus, elit ultricies aliquet porta, erat augue viverra purus, at cursus purus magna ac nunc. Fusce ultrices consectetur magna varius malesuada. Maecenas eu interdum mi. Donec lacinia arcu vestibulum risus posuere elementum. Curabitur tristique suscipit enim euismod rhoncus. Aenean orci magna, maximus at sapien vulputate, tristique congue turpis. Integer sed justo at felis scelerisque ornare.\n\nCras interdum, nisi eget vulputate euismod, ipsum justo auctor ipsum, ac posuere massa leo ut odio. Integer mattis lectus non ligula vulputate, posuere dignissim arcu congue. Aenean a mollis est. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aenean sed nunc vitae justo iaculis ultrices. Morbi in libero ut lorem euismod semper. Proin dictum id est sit amet suscipit. Vestibulum imperdiet mi ligula, sed cursus nibh pharetra non. Phasellus tortor dolor, sollicitudin nec varius sit amet, finibus vel magna.",
                    style: TextStyle(color: Colors.black),
                  ),
                  textAlign: TextAlign.justify,
                )
              ),
            ]
        )
    );
  }
}