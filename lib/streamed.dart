// StreamBuilder(
//         stream: Firestore.instance.collection('offers').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData)
//             return Center(child: CircularProgressIndicator());
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return Center(child: new CircularProgressIndicator());
//             default:
//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Center(
//                   child: new Row(
//                     children: snapshot.data.documents
//                         .map((DocumentSnapshot document) {
//                       String adam = document['tel'];
//                       return SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Padding(
//                             padding: const EdgeInsets.all(18.0),
//                             child: Container(
//                               height: 550,
//                               child: Card(
//                                 elevation: 10,
//                                 child: Column(
//                                   children: [
//                                     Text(document['name']),
//                                     Image.network(
//                                       document['img'],
//                                       scale: 1,
//                                     ),
//                                     Text(document['des']),
//                                     Text(document['price']),
//                                     SizedBox(
//                                       height: 200,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Card(
//                                           elevation: 10,
//                                           child: CircleAvatar(
//                                             backgroundColor: Colors.white,
//                                             child: IconButton(
//                                               onPressed: () {
//                                                 launch("tel://$adam");
//                                               },
//                                               icon: Icon(
//                                                 Icons.call,
//                                               ),
//                                               color: Colors.green,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 30,
//                                         ),
//                                         Card(
//                                           elevation: 10,
//                                           child: CircleAvatar(
//                                             backgroundColor: Colors.white,
//                                             child: Icon(
//                                               Icons.map,
//                                               color: Colors.red,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 30,
//                                         ),
//                                         Card(
//                                           elevation: 10,
//                                           child: CircleAvatar(
//                                             backgroundColor: Colors.white,
//                                             child: Icon(
//                                               Icons.local_fire_department,
//                                               color: Colors.orange,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ));
//                     }).toList(),
//                   ),
//                 ),
//               );
//           }
//         },
//       ),
//     );
//   }
// }
