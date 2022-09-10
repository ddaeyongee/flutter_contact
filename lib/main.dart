import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
       home: MyApp()
      ));  // const 는 상수 선언이기 때문에 굳이 필요 없음
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var a = 1;  // staful 안에 변수 선언하면 그게 바로 state 를 사용할 수 있는 상태
  var name = ['강태용', '곽동진', '애나벨']; //title name을 stateful 하게 관리
  var like = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(a.toString()),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI();
              });
        },
      ),
      appBar: AppBar(title: Text('테스트페이지 appBar'), leading: Icon(Icons.star)),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (c, i) {
          print(i);
          return ListTile(
            leading: Text(like[i].toString()),
            title: Text(name[i]),
            trailing: ElevatedButton(
              child: Text('좋아요'),
              onPressed: () {
                setState(() {
                  like[i]++;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class DialogUI extends StatelessWidget {
  const DialogUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(),
            TextButton( child: Text('완료'), onPressed:(){} ),
            TextButton(
                child: Text('취소'),
                onPressed:(){ Navigator.pop(context); })
          ],
        ),
      ),
    );
  }
}

