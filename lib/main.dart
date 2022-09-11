import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  // contact app 접근 권한을 얻는 함수를 작성 
  getPermission() async {
    var status = await Permission.contacts.status;  //연락처 권한줬는지 여부
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts(withThumbnails: false);
      // print(contacts);
      print(contacts[0].givenName);

    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request(); //허락해달라고 팝업띄우는 코드
      openAppSettings();  // 앱설정 화면 띄워 줌
    }
  }

  @override
  void initState() {    //이 widget이 처음 load 될 때
    super.initState();
    getPermission();
  }

  var total = 100;  // staful 안에 변수 선언하면 그게 바로 state 를 사용할 수 있는 상태
  // var name = ['강태용', '곽동진', '애나벨']; //title name을 stateful 하게 관리
  List<Contact> name = [];
  var like = [0, 0, 0];



  addOne(){
    setState(() {
      total++;
    });
  }

  //수정함수 만들기 -> 자식에게 보내기
  addName(a){
    setState(() {
      name.add(a);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('회원추가'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return DialogUI(addOne : addOne, addName : addName ); //작명 : 보낼 state
              });
        },
      ),
      appBar: AppBar(title: Text('연락처 어플리케이션'), actions: [
        IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
      ],),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (c, i) {
          print(i);
          return ListTile(
            // leading: Text(like[i].toString()),
            leading: Image.asset('assets/selfy.jpg', width: 100,),
            title: Text(name[i].givenName ?? '이름이 없습니다'),   // null check 문법
            // trailing: ElevatedButton(
            //   child: Text('좋아요'),
            //   onPressed: () {
            //     setState(() {
            //       // like[i]++;
            //     });
            //   },
            // ),
          );
        },
      ),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne , this.addName }) : super(key: key);
  final addOne;  //부모가 보낸 state는 read-only 가 좋다
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(controller: inputData,),
            TextButton( child: Text('완 료'), onPressed:(){
              // addOne();
              // addName(inputData.text);

              var newContact = Contact();
              newContact.givenName = inputData.text;  //새로운 연락처 만들기
              ContactsService.addContact(newContact);  //실제로 연락처에 집어넣기
              addName(newContact);   //심심해서 name이라는 state에도 저장해줌
            } ),
            TextButton(
                child: Text('취소'),
                onPressed:(){ Navigator.pop(context); })
          ],
        ),
      ),
    );
  }
}
