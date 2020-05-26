import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_app/Data/News_Api.dart';
import 'package:new_app/Data/data.dart';
import 'package:new_app/Model/ArticlesModel.dart';
import 'package:new_app/Model/model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> category = new List<CategoryModel>();
  List<ArticlesModel> articles = new List<ArticlesModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategory();
    getNew();

  }
  
  getNew() async{
    News newClass = News();
    await newClass.getNews();
    articles = newClass.news;
    setState(() {
      _loading = false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appBar
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("News"),
            new Text(
              "App",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
        elevation: 1.0,
      ),
      body: _loading ? Center(
       child: Container(
         child: CircularProgressIndicator(),
       ), 
      ):
         SingleChildScrollView(
           child: new Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: new Column(
              children: <Widget>[
                Container(
                  height: 70,
                  child: ListView.builder(
                    shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        return Category_section(
                          imageUrl: category[index].imageUrl,
                          categoryName: category[index].categoryName,
                        );
                      }),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 17),
                  child: ListView.builder(
                    itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                      return Catergory_data(imageUrl: articles[index].urlToImage, 
                          title: articles[index].title,
                          description: articles[index].descripition);
                      }
                  ),
                )
              ],
            ),
        ),
         ),
    );
  }
}

class Category_section extends StatelessWidget {
  final imageUrl;
  final categoryName;

  Category_section({this.categoryName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //catergory section
      onTap: (){

      },
      child: new Container(
        margin: EdgeInsets.only(right: 16),
        child:Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120, height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26
            ),
            child: Text(categoryName, style: TextStyle(color: Colors.white,fontSize: 14, fontWeight: FontWeight.w500),),
          )
        ],
      )
      ),
    );
  }
}

//data Parameter
class Catergory_data extends StatelessWidget {
  final String imageUrl,title,description;
  Catergory_data({@required this.imageUrl, @required this.title, @required this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 17),
      child: Column(
        children: <Widget>[
          ClipRRect (
            borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)),
          SizedBox(height: 10,),
          Text(title, style: TextStyle(fontSize: 20),),
          SizedBox(height: 10.0,),
          Text(description)
        ],
      ),
    );
  }
}

