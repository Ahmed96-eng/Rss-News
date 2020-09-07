import 'package:flutter/material.dart';
import 'package:rss_news/API/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class News extends StatefulWidget {
  final String title;
  String apiUrl;

  News({@required this.apiUrl, this.title});

  @override
  NewsState createState() => NewsState();
}

class NewsState extends State<News> {
  //

  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no_image.png';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18.0, fontFamily: 'Cairo', fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16.0,
          fontWeight: FontWeight.w100,
          color: Colors.grey[900]),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

//  thumbnail(imageUrl) {
//    return Padding(
//      padding: EdgeInsets.only(left: 15.0),
//      child: CachedNetworkImage(
//        placeholder: (context, url) => Image.network(
//            'https://img.favpng.com/22/16/8/cnn-news18-logo-png-favpng-S0RfhCMSz85vWVMg8tNXUW91r.jpg'),
//        imageUrl: imageUrl ?? 'NO Image',
//        height: 50,
//        width: 70,
//        alignment: Alignment.center,
//        fit: BoxFit.fill,
//      ),
//    );
//  }
//

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  Future load(String apiUrl) async {
    updateTitle(loadingFeedMsg);

    await loadFeed(apiUrl).then((result) {
      if (null == result || result.toString().isEmpty) {
        Center(
          child: Text('no data'),
        );
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load(widget.apiUrl);
  }

  isFeedEmpty() {
    return null == _feed || _feed.items.isEmpty;
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: isFeedEmpty()
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                backgroundColor: Colors.greenAccent,
                key: _refreshKey,
                child: ListView.builder(
                  itemCount: _feed.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _feed.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Card(
                        child:
                            /*Padding(
                          padding: EdgeInsets.only(right: 10),
                          child:*/
                            ListTile(
                          title: title(item.title),
                          subtitle: subtitle(item.pubDate),
                          // leading: thumbnail(item.author),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                            size: 30.0,
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                          onTap: () => openFeed(item.link.toString()),
                          // ),
                        ),
                      ),
                    );
                  },
                ),
                onRefresh: () => load(widget.apiUrl),
              ),
      ),
    );
  }
}
