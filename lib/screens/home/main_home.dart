import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            color: Colors.grey[200],
            height: 40,
            child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(),
                    hintText: "모임을 찾아보세요 :)",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ))),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("I'm location");
            },
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              print("I'm notification");
            },
            icon: Icon(
              Icons.notifications_active,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                Text("내 주변 스타일모임 ✨",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Spacer(),
                Text("신규순"),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Card(
                    elevation: 0,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'http://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/081/089/938/81089938_1533022970349_1_600x600.JPG',
                          fit: BoxFit.fill,
                          height: 160,
                          width: 120,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.orange[50],
                                      child: Text(
                                        "진행중",
                                        style: TextStyle(
                                            color: Colors.orange[400]),
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text("주말 저녁에 같이 쇼핑해요",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 10),
                                Text(
                                  "여의도 5월 21일 (토) 오후 2시",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://photo.jtbc.joins.com/news/2018/02/25/20180225163702887.jpg",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://w.namu.la/s/9cd582da34c2e1e0cf8600958aff9948a5bbe4e5e074a8d72924a142e7c6048f03b426627badd19accadeed9befd3857f9394808a49e52731706ca5b26f7e6d410f4721860374f956cea3d0e10d9408b",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Taeyang_-_MADE_THE_MOVIE_Premiere_%28cropped%29.jpg/250px-Taeyang_-_MADE_THE_MOVIE_Premiere_%28cropped%29.jpg",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "3/4 명 참여중",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Card(
                    elevation: 0,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'http://image.genie.co.kr/Y/IMAGE/IMG_ALBUM/081/089/938/81089938_1533022970349_1_600x600.JPG',
                          fit: BoxFit.fill,
                          height: 160,
                          width: 120,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.orange[50],
                                      child: Text(
                                        "진행중",
                                        style: TextStyle(
                                            color: Colors.orange[400]),
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text("주말 저녁에 같이 쇼핑해요",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 10),
                                Text(
                                  "여의도 5월 21일 (토) 오후 2시",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://photo.jtbc.joins.com/news/2018/02/25/20180225163702887.jpg",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://w.namu.la/s/9cd582da34c2e1e0cf8600958aff9948a5bbe4e5e074a8d72924a142e7c6048f03b426627badd19accadeed9befd3857f9394808a49e52731706ca5b26f7e6d410f4721860374f956cea3d0e10d9408b",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Taeyang_-_MADE_THE_MOVIE_Premiere_%28cropped%29.jpg/250px-Taeyang_-_MADE_THE_MOVIE_Premiere_%28cropped%29.jpg",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              36 / 2 - 36 / 18),
                                          child: Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Taeyang_-_MADE_THE_MOVIE_Premiere_%28cropped%29.jpg/250px-Taeyang_-_MADE_THE_MOVIE_Premiere_%28cropped%29.jpg",
                                            height: 36,
                                            width: 36,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      "마감",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
