// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:no_name_app/controller/register_controller.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: RegisterController(),
//       builder: (RegisterController _controller) {
//         return Scaffold(
//             appBar: AppBar(),
//             body: Container(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Text('Xin chào ' + _controller.userModel.name!),
//                   const Text(
//                       'Lần đầu tiên sử dụng ứng dụng, Hãy chọn loại tài khoản mà bạn muốn'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           _controller.onUpdateRole('worker');
//                         },
//                         child: Container(
//                           color: Colors.blue[400],
//                           height: 120,
//                           width: 120,
//                           child: const Center(child: Text('Người giúp việc')),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           _controller.onUpdateRole('finder');
//                         },
//                         child: Container(
//                           color: Colors.green[300],
//                           height: 120,
//                           width: 120,
//                           child:
//                               const Center(child: Text('Tìm người giúp việc')),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }
