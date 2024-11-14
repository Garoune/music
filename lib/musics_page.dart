import 'package:flutter/material.dart';
import 'package:flutter_music/play_page.dart';
import 'package:on_audio_query/on_audio_query.dart';


class MusicsPage extends StatefulWidget {
  const MusicsPage({super.key});

  @override
  State<MusicsPage> createState() => _MusicsPageState();
}

class _MusicsPageState extends State<MusicsPage> {
  final OnAudioQuery onAudioQuery=OnAudioQuery();
  List <SongModel>? songs;

  void getSongs()async{
    bool hasPermission =await onAudioQuery.checkAndRequest(retryRequest: true);
    if (hasPermission) {
      songs=await onAudioQuery.querySongs();
      setState(() {
        
      });
      
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1B1B1B),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 20,
                ),
                Text(
                  'Mico Music Player',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                    child: Expanded(
                  child:songs== null? Center(child: CircularProgressIndicator()) :ListView.builder(
                    itemCount: songs!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 24),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/artworks.png.jpg',
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'songs! [index].titele',
                                        style: TextStyle(
                                            color: Color(0xff9B9B9B), fontSize: 18),
                                      ),
                                      Text(
                                        'songs[index].artist',
                                        style: TextStyle(
                                            color: Color(0xff5C5C5B), fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ))
              ],
            ),
          ),
        ),
      );
  }
}