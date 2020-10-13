import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/service/tv.dart';

class Tv extends StatefulWidget {
  @override
  _TvState createState() => _TvState();
}

class _TvState extends State<Tv> {
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;
  int _page = 1;

  List tv = new List();

  void _getMoreData(int pageNumber) async {
    print(pageNumber);
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      List tempList = new List();

      List response = await TvApi().getTv(tvList, pageNumber);
      for (int i = 0; i < response.length; i++) {
        tempList.add(response[i]);
      }
      tv.addAll(tempList);
      isLoading = false;

      setState(() {
        // tv.addAll(tempList);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMoreData(_page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_page < 8) _getMoreData(_page += 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return tv.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: tv.length,
            itemBuilder: (_, int index) => index == tv.length - 1
                ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : 
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Card(
                              semanticContainer: true,
                              elevation: 5,
                              child: posterImage(tv[index].posterPath))),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              tv[index].name,
                              // textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14.0,
                               fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              tv[index].overview,
                              // textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 12.0,
                               
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
            controller: _scrollController,
          );
  }
}

Widget posterImage(String image) {
  return CachedNetworkImage(
    fit: BoxFit.fill,
    imageUrl: image,
    placeholder: (context, url) => Image.network(
      "http://via.placeholder.com/200x150",
      fit: BoxFit.fill,
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
