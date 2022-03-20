import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green, minimumSize: Size(50, 50)),
                        child: Text(
                          "create invitation",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green, minimumSize: Size(50, 50)),
                        onPressed: () {},
                        child: Text(
                          "use invitation",
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                )),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Text(
                    "follower1",
                    style: TextStyle(color: Colors.green, fontSize: 40),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "follower2",
                    style: TextStyle(color: Colors.green, fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "follower3",
                    style: TextStyle(color: Colors.green, fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "follower4",
                    style: TextStyle(color: Colors.green, fontSize: 40),
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
