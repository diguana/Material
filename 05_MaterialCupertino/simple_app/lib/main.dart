import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TabItem {
    String title;
    Icon icon;
    TabItem({this.title, this.icon});
  }
  final List<TabItem> _tabBar = [
    TabItem(title: "Photo", icon: Icon(Icons.photo)),
    TabItem(title: "Chat", icon: Icon(Icons.chat)),
    TabItem(title: "Albums", icon: Icon(Icons.album)),
  ];

class _MyHomePageState extends State<MyHomePage>
  with SingleTickerProviderStateMixin {

  TabController _tabController;
  int _selectedIndex = 0;
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controller;

  void showBottomSheet(){
    if(_controller == null){
      _controller = scaffoldKey.currentState.showBottomSheet(
        (context) => Container(
          color: Colors.grey[200],
          height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(icon: const Icon(Icons.credit_card)),
                          Text('Сумма'),
                        ],
                      ),
                  ),
                  Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text('200 руб'),
                      ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Оплатить'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300],
                  onPrimary: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      _controller.close();
      _controller = null;
    }
  }

  void initState(){
  super.initState();
  _tabController = TabController(length: _tabBar.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
}


  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleButton =
    ElevatedButton.styleFrom(
      primary: Colors.grey[200],
      onPrimary: Colors.black,
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title,),
        centerTitle: true,
        actions: [
          Builder(
            builder: ((context) => 
            IconButton(onPressed: (){
              Scaffold.of(context).openEndDrawer();
            }, 
            icon: Icon(Icons.account_circle)))),
        ],
      ),

    drawer: Drawer(
    child: Column(
      children: [
        Expanded(
          child: Column(
            children: [
              const DrawerHeader(
                child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage('https://picsum.photos/1200/501'),
          ),
              ),
        ListTile(
          leading: Icon(Icons.account_box_outlined),
          title: Text('Profile'),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Images'),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          leading: Icon(Icons.file_copy),
          title: Text('Files'),
          trailing: Icon(Icons.arrow_forward),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: SafeArea(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                ElevatedButton(
                  onPressed: () {}, 
                  child: Text("Выход"),
                  style: styleButton,
                  ),
                  
                ElevatedButton(
                  onPressed: () {}, 
                  child: Text("Регистрация"),
                  style: styleButton,
                  ),
              ],
            ), minimum: EdgeInsets.only(bottom: 20),),
          ),),
            ],
          )),
        
      ],
      
    ),
    
  ),
    endDrawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('https://picsum.photos/1200/502'),
            ),
            SizedBox(height: 10),
            Text('Михаил По'),
          ],
        ),
      ),

       body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            child: Center(child: Text('Photo')),
          ),
          Container(
            child: Center(child: Text('Chat')),
          ),
          Container(
            child: Center(child: Text('Albums')),
          )
        ],
      ),
     bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
          setState(() {
            _tabController.index = index;
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          for (final item in _tabBar)
            BottomNavigationBarItem(
                icon: item.icon,
                label: item.title
            )
        ],
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showBottomSheet,
      ),
      
    );
  }
}
