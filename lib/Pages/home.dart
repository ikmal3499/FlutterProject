
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modals/category_models.dart';
import 'package:flutter_application_1/modals/diet_model.dart';
import 'package:flutter_application_1/modals/popular_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];
  List<CategoryModel> filteredCategories = [];
  List<DietModel> filteredDiets = [];

  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getInitialInfo();
    searchController.addListener(_onSearchChanged);
  }

  // ignore: unused_element
  void _getCategories() {
    categories = CategoryModel.getCategories();
    filteredCategories = List.from(categories);
  }

  // ignore: unused_element
  void _getDiets() {
    diets = DietModel.getDiets();
    filteredDiets = List.from(diets);
  }
  
  // void _getCategories(){
  void _getInitialInfo(){
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();

    setState(() {
      // Filter categories
      filteredCategories = categories
          .where((category) =>
              category.name.toLowerCase().contains(query))
          .toList();

      // Filter diets
      filteredDiets = diets
          .where((diet) =>
              diet.name.toLowerCase().contains(query) ||
              diet.level.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      drawer: _drawer(context),
      backgroundColor: Colors.white,
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchField(),
          SizedBox(height: 40,),
          _categoriesSection(),
          SizedBox(height: 40,),
          _dietSection(),
          SizedBox(height: 40,),
          _popularSection(),
          const SizedBox(height: 40,),
        ],
      ),
    );
  }

  Column _popularSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            const SizedBox(height: 15,),
            ListView.separated(
              itemCount: popularDiets.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 25,),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        popularDiets[index].iconPath,
                        width: 65,
                        height: 65,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularDiets[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                          Text(
                            popularDiets[index].level + ' | ' + popularDiets[index].duration + ' | ' + popularDiets[index].calorie,
                            style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: SvgPicture.asset(
                          'assets/icons/button.svg',
                          width: 30,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: popularDiets[index].boxIsSelected ?
                    Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: popularDiets[index].boxIsSelected ? [
                      BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.07),
                        offset: const Offset(0, 10),
                        blurRadius: 40,
                        spreadRadius: 0
                      )
                    ] : []
                  ),
                );
              },
            )
          ],
        );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
            Icons.air,
            size: 48,
            )
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("P R O F I L E"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/firstPage');
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("S E T T I N G S"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settingPage');
            },
          )
        ],
      ),
    );
  }

Column _dietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left:20),
              child: Text(
                'Recommendation\nfor Diet',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              height: 240,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    width: 210,
                    decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(diets[index].iconPath),
                        Column(
                          children: [
                            Text(
                              diets[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16
                              ),
                            ),
                            Text(
                              diets[index].level + ' | ' + diets[index].duration + ' | ' + diets[index].calorie,
                              style: const TextStyle(
                                color: Color(0xff7B6F72),
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 45,
                          width: 130,
                          child: Center(
                            child: Text(
                              'View',
                              style: TextStyle(
                                color: diets[index].viewIsSelected ? Colors.white : const Color(0xffC58BF2),
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                diets[index].viewIsSelected ? const Color(0xff9DCEFF) : Colors.transparent,
                                diets[index].viewIsSelected ? const Color(0xff92A3FD) : Colors.transparent
                              ]
                            ),
                            borderRadius: BorderRadius.circular(50)
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 25,),
                itemCount: diets.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                left: 20,
                right: 20
              ),
              ),
            )
          ],
        );
  }

  Column _categoriesSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Catogery',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
                ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 120,
              color: Colors.white,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
                separatorBuilder: (context, index) => SizedBox(width: 25),
                itemBuilder: (context, index){
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconPath),
                          ),
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        );
  }

  Container _searchField() {
    return Container(
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              )
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search Pancake',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              )
            ),
          ),
        );
  }

  AppBar appBar(){
    return AppBar(
      title: Text(
          'Homepage',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,

        // leading: GestureDetector(
        //   onTap: (){

        //   },
        //   child: Container(
        //     margin: EdgeInsets.all(10),
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //       color: const Color.fromARGB(255, 255, 255, 255),
        //       borderRadius: BorderRadius.circular(10)
        //     ),
        //     child: SvgPicture.asset(
        //       'assets/icons/Arrow - Left 2.svg',
        //       height: 20,
        //       width: 20,
        //       ),
        //   ),
        // ),
    );
  }
}