import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:plomero_express/Screens/LoginScreen.dart';
import 'package:plomero_express/Screens/Mapas.dart';
import 'package:plomero_express/Screens/Trabajos.dart';
import 'Mapas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';




class ScreensButtons extends StatefulWidget
{
  _ScreensButtons createState() => _ScreensButtons();
}

class _ScreensButtons extends State<ScreensButtons>
{
  int _selectedIndex = 0;
  

Future<void> SignOut(BuildContext context) async
{
await FirebaseAuth.instance.signOut();
Navigator.pushReplacementNamed(context, "/login");

}
  final List<Widget> _screens = 
[
  Home(),
  Trabajos(),
  Mapas(),
  

  ];

  final List<IconData> icons = [
    Icons.work,
    Icons.map_rounded,
    Icons.money,
    Icons.home,
    Icons.home
  ];

  final NotchBottomBarController _notchBottomBarController =NotchBottomBarController(index: 0);

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Plomero Express'),
            
     
          ]),
        
        actions: [
          
          
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: ()
              {
                showMenu(context: context,
                          position: RelativeRect.fromLTRB(50, 50, 50, 50),
                         items: [
                          PopupMenuItem<String>
                              (
                                value: 'profile',
                                child: Row(children: 
                                          [
                                            Icon(Icons.account_circle_outlined),
                                            SizedBox(width: 8),
                                            Text('Ver Perfil')

                                          ]
                                         ,)
                              ,),
                            PopupMenuItem<String> (
                              value: 'signOut',
                              child: Row(children:
                                [
                                  Icon(Icons.exit_to_app),
                                  SizedBox(width: 8),
                                  Text('Cerrar Sesión')
                                ],)
                      
                            )
                         ],
                         elevation: 8.0,
                          ).then((value)
                          {
                              if (value == 'profile')
                              {
                                print('Ir al perfil');
                              } 
                              else if(value == 'signOut')
                              {
                                SignOut(context);
                              }

                           }
                          );
              }
            )
         ]               

      ),
      body: _screens[_selectedIndex],


        bottomNavigationBar: BottomAppBar(
          color: Colors.blueAccent,
          elevation: 0,
          clipBehavior: Clip.none,  
              child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,  // 🔹 Evita distorsión en los íconos
                      currentIndex: _selectedIndex,
                      selectedItemColor: Colors.orange,
                      unselectedItemColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      iconSize: 22,
                      showUnselectedLabels: false,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.work),
                        label: 'Trabajos',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map_rounded),
                        label: 'Mapas',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.build),
                        label: 'Materiales',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.receipt_long),
                        label: 'Facturas',
                      ),
                    ],
                  ),
                ),
                        


          
          
      

    
        
    );
  }
}

 /* 
 @override
 Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Plomero Expreess"),
    ) ,
    body: 
        IndexedStack(
      index: _selectedIndex,
      children: _screens),

    bottomNavigationBar: CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      height: 60,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.white),
          Icon(Icons.home, size: 30,color: Colors.green),
          Icon(Icons.home, size: 30,color: Colors.red),
        ],
        onTap: (index)
        {
          setState(() {
            _selectedIndex=index;
          });
        },
          )
        
        );
 }

}
*/

class Home extends StatefulWidget{

@override
_Home createState() => _Home();
}

class _Home extends State<Home>{



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio")),
        body: Column(
        children: [
          Card(
               elevation: 5,
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Column(
                    children: [
                      Text("Trabajos Activos"),
                      SizedBox(height: 20),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Trabajo 1"),
                              subtitle: Text("Estado: En progreso"),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: (){},
                            ),

                             ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Trabajo 1"),
                              subtitle: Text("Estado: En progreso"),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: (){},
                            ),

                             ListTile(
                              leading: Icon(Icons.work),
                              title: Text("Trabajo 1"),
                              subtitle: Text("Estado: En progreso"),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: (){},
                            ),

                            SizedBox(height: 20),

                            ElevatedButton(onPressed:(){} , child: Text("Agregar Trabajo"))
                          ],

                        ),
                      )


                    ]
                  )

                  
                ),
              )
          ],

        ),
        );
      
  }
  }

