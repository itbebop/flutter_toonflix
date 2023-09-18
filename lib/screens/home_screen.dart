import 'package:flutter/material.dart';
import 'package:flutter_toonflix/models/webtoon_model.dart';
import 'package:flutter_toonflix/services/api_service.dart';
import 'package:flutter_toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    //print(webtoons);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, future) {
          if (future.hasData) {
            /*return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: future.data!.length,
              itemBuilder: (context, index) {
                print(index);
                var webtoon = future.data![index];
                return Text(webtoon.title);
              },
            );
            */
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                    child: makeList(
                        future)), //listView의 높이가 없어서 에러나야(but 안나고 화면 안나옴)
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> future) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 20), // padding을 넣어야 shadow 윗부분 안끊기고 나옴
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      itemCount: future.data!.length,
      itemBuilder: (context, index) {
        print(index);
        var webtoon = future.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
    );
  }
}
