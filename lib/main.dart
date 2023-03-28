import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}





class HomePage extends StatefulWidget { // 부모를 stateful로 변경 ( 상태를 부모에게 넘긴다)

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 상태 관리 변수
  int number = 1;
  
  // 상태 관리 메소드가 필요
  void add(){ 
    setState(() { // setState는 stateful 위젯이 가지고 있다
      number += 1;
    });
  }

  void down(){
    setState(() { // setState는 stateful 위젯이 가지고 있다
      number -= 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: HeaderPage(number)),
            Expanded(child: BottomPage(add)),  // 1급 함수 자체를 넘긴다. // 그래서 함수를 ()안붙이고 이름으로만 사용함 1급이니까
            Expanded(child: BottomPage(down)),
          ],
        ),
      ),
    );
  }
}


class HeaderPage extends StatelessWidget { // stateless로 변경 ( 
  // 전달 받은 변수
  final int number; // 생성자에 시그니처를 넣어서 new로 만드는 방법 ( 다른방법도 있지만 이걸 먼저 배워봄 )
  HeaderPage(this.number, {Key? key}) : super(key: key);
    // 시그니처의 사용이유과 에러가 발생하지 않게 되는 이유는 ?

  @override
  Widget build(BuildContext context) {
     return Container(
      color: Colors.red[300],
      child: Align(
          child: Text(
            "$number",
            style: TextStyle(color: Colors.white, fontSize: 100, fontWeight: FontWeight.bold),
          )),
    ); // UI에서 변화할 부분.
  }

 // State 생성.
// setState는 stateful이 가지고 있는 속성 그러면 stateless에서 stateful을 바꾸려면?
// setState를 하면 변경을 감지한 State가 새롭게 createState()를 때리게 된다.
// 외부에서 상태를 관리하려면 다른 방법이 필요함
// 상태를 외부에 저장해서 stateful의 상태를 stateless 위젯이 변경하는 방법이 있음
// 즉 상태 관리는 stateful과 stateless의 부모가 관리 한다. 상태를 부모한테 넘기면 연결이 된다.
// 이때 부모를 stateful로 바꿀수도 있는데 stateful의 단위 ? 범위를 최대한 작게 잡아야한다. 왜냐하면 stateful은 상태가 변하면 변경감지를 하고 변한 데이터를
// 다시 그리게 되는데 이때 범위가 크다면 느려질수밖에 없다.
}

class BottomPage extends StatelessWidget {
  // 전달 받을 함수 설정
  // Function add; 이게 정확한 표현이지만 아래처럼 추상적으로 사용- 타입추론
   final add;
   BottomPage(this.add, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[300],
      child: Align(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[200],
              minimumSize: Size(300, 200)
            ),
          onPressed: (){
            add();
          },
          child: Text("증가", style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
