import 'package:flutter/material.dart';
import '../commonwidgets/home_widget.dart';
import '../core/colors.dart';
import '../model/source_model.dart';
import '../search/search_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  late NewsArt newsArt;

  GetNews() async {
    newsArt = await FetchNews.fetchNews();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: colorblue,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
              },
            ),
            // SizedBox(width: 1,),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: const Text(
            //     'Discover', // Text next to the icon
            //     style: TextStyle(color:colorblue),
            //   ),
            // ),
          ],
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'My Feed',
            style: TextStyle(color: kblack, fontSize: 20),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: colorblue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView.builder(
          controller: PageController(initialPage: 0),
          scrollDirection: Axis.vertical,
          onPageChanged: (value) {
            setState(() {
              isLoading = true;
            });
            GetNews();
          },
          itemBuilder: (context, index) {
            return isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NewsContainer(
                    imgUrl: newsArt.imgUrl,
                    newsCnt: newsArt.newsCnt,
                    newsHead: newsArt.newsHead,
                    newsDes: newsArt.newsDes,
                    newsUrl: newsArt.newsUrl);
          }),
    );
  }
}
