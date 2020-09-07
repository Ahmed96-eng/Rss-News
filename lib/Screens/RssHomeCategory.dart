import 'package:flutter/material.dart';
import 'package:rss_news/Services/apiRoutes.dart';

import 'news.dart';

class RssHomeCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Rss News')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTileWidget(
                id: 1,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار رئيسية',
              ),
              ListTileWidget(
                id: 2,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار عالمية',
              ),
              ListTileWidget(
                id: 3,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار الرياضة',
              ),
              ListTileWidget(
                id: 4,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار العلوم',
              ),
              ListTileWidget(
                id: 5,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار إقتصادية',
              ),
              ListTileWidget(
                id: 6,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار الشرق الأوسط ',
              ),
              ListTileWidget(
                id: 7,
//              imageUrl:
//                  'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg',
                title: 'أخبار ترفيهية ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  String imageUrl, title;
  int id;

  ListTileWidget({this.id, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 10, left: 8),
          child: ListTile(
//            leading:
//            Image.network(
//              imageUrl,
//              fit: BoxFit.fill,
//              height: 50,
//              width: 50,
//            ),
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.blue[900], fontSize: 18, fontFamily: 'Cairo'),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue[900],
            ),
          ),
        ),
      ),
      onTap: () {
        id == 1
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        News(apiUrl: ApiRoutes.topNewsUrl, title: title)))
            : id == 2
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            News(apiUrl: ApiRoutes.worldNewsUrl, title: title)))
                : id == 3
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => News(
                                apiUrl: ApiRoutes.sportNewsUrl, title: title)))
                    : id == 4
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => News(
                                    apiUrl: ApiRoutes.scienceNewsUrl,
                                    title: title)))
                        : id == 5
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => News(
                                        apiUrl: ApiRoutes.businessNewsUrl,
                                        title: title)))
                            : id == 6
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => News(
                                            apiUrl: ApiRoutes.meddleEastNewsUrl,
                                            title: title)))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => News(
                                            apiUrl:
                                                ApiRoutes.entertainmentNewsUrl,
                                            title: title)));
      },
    );
  }
}
