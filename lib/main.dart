import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());  // const 는 상수 선언이기 때문에 굳이 필요 없음
}


var  a = 1 ;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Text(a.toString()),
            onPressed: (){
              print(a);
              a++;
            },
          ),
          appBar: AppBar(
            title: Text('테스트페이지 appBar'),
            leading: Icon(Icons.star)
          ),
          body: ListView.builder(
            itemCount: 10,
            itemBuilder: (c, i){
              print(i);
              return ListTile(
                leading: Image.asset('selfy.jpg'),
                title: Text('반복테스트중'),
              );
            },
          ),
        )
    );

  }
}
