import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_homeward/model/user_model.dart';

import 'package:http/http.dart' as http;
import 'homepage.dart';

// Map data;

Future<Photo> fetchPhotos(http.Client client, var id, var token) async {
  print('Id : $id');
  final response = await client.get(
      Uri.parse('https://60585b2ec3f49200173adcec.mockapi.io/api/v1/blogs/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: token,
      });
  print(response.body);
  final responseJson = jsonDecode(response.body);
  // data = json.decode(response.body);
  // data.forEach((key, value) => userData.add(Customer(key, value)));
  // print(userData);

  // List<Photo> realdata = List<Photo>.from(data).map((x) => Photo.fromJson(json)));

  return Photo.fromJson(responseJson);
}

// List<Photo> parsePhotos(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
// }

class SingleBlog extends StatefulWidget {
  @override
  _SingleBlogState createState() => _SingleBlogState();
}

class _SingleBlogState extends State<SingleBlog> {
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments;
    print(id);
    var token = getToken();

    print(token);

    return Scaffold(
        appBar: AppBar(title: Text("Blog Screen")),
        body: FutureBuilder<Photo>(
          future: fetchPhotos(http.Client(), id, token),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data.imageUrl)),
                    title: Text(snapshot.data.title),
                    subtitle: Text(snapshot.data.createdAt),
                  )
                // Column(
                //     children: [
                //       Image.network(snapshot.data.imageUrl),
                //       Text(snapshot.data.title),
                //       Text(snapshot.data.createdAt),
                //     ],
                //   )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}

// class PhotosList extends StatelessWidget {
//   final List photos;

//   PhotosList({Key key, this.photos}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: photos.length,
//       itemBuilder: (context, int index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: ListTile(
//             leading: CircleAvatar(
//                 backgroundImage: NetworkImage(photos[index].imageUrl)),
//             title: Text(photos[index].title),
//             subtitle: Text(photos[index].createdAt),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_homeward/api/api_service.dart';
// import 'package:flutter_homeward/model/user_model.dart';

// class DetailLogoView extends StatefulWidget {
//   @override
//   _DetailLogoViewState createState() => _DetailLogoViewState();
// }

// class _DetailLogoViewState extends State<DetailLogoView> {
//   List<Photo> logo;

//   var id;

//   @override
//   Widget build(BuildContext context) {
//     id = ModalRoute.of(context).settings.arguments;
//     print(id);

//     APIService service = new APIService();
//     var token = service.token;
//     print(token);
//     return Scaffold(
//       body: Center(
//         child: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               title: Text('Blog Details'),
//               backgroundColor: Colors.green,
//               expandedHeight: 350.0,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Image.network(
//                   logo[int.parse(id) - 1].imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 logoDetails(),
//                 Container(
//                   height: 200,
//                 )
//               ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget logoDetails() {
//     return Card(
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   logo[int.parse(id) - 1].title,
//                   style: TextStyle(fontSize: 30, color: Colors.green[900]),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
//                 child: Text(logo[int.parse(id) - 1].createdAt),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
