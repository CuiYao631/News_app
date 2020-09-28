import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/widgets.dart';
import 'package:news_app/pages/account/account.dart';
import 'package:news_app/pages/bookmarks/bookmarks.dart';
import 'package:news_app/pages/category/category.dart';
import 'package:news_app/pages/main/main.dart';

class ApplicationPage extends StatefulWidget {
  ApplicationPage({Key key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  final List<String> _tabTitles = ["欢迎", "类别", "书签", "账户"];

  PageController _pageController;

  ///初始状态
  @override
  void initState(){
    super.initState();
    _pageController=new PageController(initialPage: this._page);
  }
  //销毁状态
  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  //底部导航栏项目
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
      icon: Icon(
        IconFont.home,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(IconFont.home, color: AppColors.secondaryElementText),
      title: Text("main"),
      backgroundColor: AppColors.primaryBackground,
    ),
    new BottomNavigationBarItem(
      icon: Icon(
        IconFont.grid,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(IconFont.grid, color: AppColors.secondaryElementText),
      title: Text("category"),
      backgroundColor: AppColors.primaryBackground,
    ),
    new BottomNavigationBarItem(
      icon: Icon(
        IconFont.tag,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(IconFont.tag, color: AppColors.secondaryElementText),
      title: Text("tag"),
      backgroundColor: AppColors.primaryBackground,
    ),
    new BottomNavigationBarItem(
      icon: Icon(
        IconFont.me,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(IconFont.me, color: AppColors.secondaryElementText),
      title: Text("my"),
      backgroundColor: AppColors.primaryBackground,
    ),
  ];

  ///tab栏动画
  void _handleNavBarTap(int index) {
    _pageController.animateToPage(index, duration: const Duration(microseconds: 100), curve: Curves.ease);
  }
  ///tab栏页码切换
  void _handlePageChanged(int page) {
    setState(() {
      this._page=page;
    });
  }


  ///顶部导航
  Widget _buildAppBar() {
    return  transparentAppBar(
      context: context,
     title: Text(
       _tabTitles[_page],
       style: TextStyle(
         color: AppColors.primaryText,
         fontFamily: 'Montserrat',
         fontSize: duSetFontSize(18.0),
         fontWeight: FontWeight.w600
       ),
     ),
    ///返回按钮 感觉多余暂时去掉
//      leading: IconButton(
//        icon: Icon(
//          Icons.arrow_back,
//          color: AppColors.primaryText,
//        ),
//        onPressed: (){
//          Navigator.pop(context);
//        },
//      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: AppColors.primaryText,
          ),
          onPressed: (){},
        ),
      ]
    );
  }

  ///内容页
  Widget _buildPageView() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        MainPage(),
        CategoryPage(),
      BookmarksPage(),
      AccountPage(),
      ],
      controller: _pageController,
      onPageChanged: _handlePageChanged,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _bottomTabs,
      currentIndex: _page,
      type: BottomNavigationBarType.fixed,
      onTap: _handleNavBarTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
