import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('테스트중입니다'),
            leading: Icon(Icons.star)
          ),
          body: ShopItem(),
        )
    );

  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({Key? key}) : super(key: key);

  @override
  build(context) {
    return SizedBox(
      child: Text('안녕'),
    );
  }
}
