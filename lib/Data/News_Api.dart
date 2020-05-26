import 'package:new_app/Model/ArticlesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class News{
  List<ArticlesModel> news = [];

Future<void> getNews() async {
  String url ="http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e4906f2e3e5942388d745d8e0e0ee9a5";
  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);

  if(jsonData['status'] == "ok"){
    jsonData['articles'].forEach((element){
      if(element['urlToImage'] != null && element['description'] != null){
        ArticlesModel articlesModel = ArticlesModel(
         title: element['title'],
          descripition: element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          content: element['context']
        );
        news.add(articlesModel);
      }
    });
  }
}
}