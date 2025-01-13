import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterblogproject/anasayfa.dart';
import 'package:flutterblogproject/main.dart';
import 'package:flutterblogproject/yazisayfasi.dart';

class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar( 
title: Text("Profil Sayfasi"),

actions: <Widget> [ // appbarın sağında görüncek widgetlar
  IconButton(
    icon : Icon(Icons.home),onPressed: () {
  Navigator.pushAndRemoveUntil ( // Bu yöntem, genellikle kullanıcıyı bir ana sayfaya veya giriş ekranına yönlendirmek ve önceki sayfalara geri dönmesini engellemek için kullanılır.
    context,
  MaterialPageRoute(builder:(_)=> Anasayfa() ), 
   (Route<dynamic>route) => true );
    }
  ),

  IconButton(
     icon: Icon(Icons.exit_to_app),
     onPressed: () {
FirebaseAuth.instance.signOut().then((deger) { // then başarılı olduktan sonra Bu bloğun içine, oturum kapatma işlemi başarılı olduğunda yapılması gereken işlemler yazılır.
  Navigator.pushAndRemoveUntil ( // Bu yöntem, genellikle kullanıcıyı bir ana sayfaya veya giriş ekranına yönlendirmek ve önceki sayfalara geri dönmesini engellemek için kullanılır.
    context,
  MaterialPageRoute(builder:(_)=> Iskele() ),
  // yeni sayfa geçişi oluşumu yeni açılcak sayfa 
  (Route<dynamic>route) => false,
//Yığındaki tüm sayfaların kaldırılması gerektiğini söyler.
  );
});
   } ),
],



),
floatingActionButton:FloatingActionButton(child : Icon(Icons.add), onPressed: (){
  Navigator.pushAndRemoveUntil ( // Bu yöntem, genellikle kullanıcıyı bir ana sayfaya veya giriş ekranına yönlendirmek ve önceki sayfalara geri dönmesini engellemek için kullanılır.
    context,
  MaterialPageRoute(builder:(_)=> YaziEkrani() ),
  // yeni sayfa geçişi oluşumu yeni açılcak sayfa 
  (Route<dynamic>route) => true,
//Yığındaki tüm sayfaların kaldırılması gerektiğini söyler.
  );
}) ,


body: Column(
  children: [
    Expanded(
      child: KullaniciYazilari(), // KullaniciYazilari body'de gösteriliyor
    ),
    Expanded(
      child: ProfilTasarimi(), // ProfilTasarimi da body'ye eklendi
    ),
  ],
),

     );
  }
}

class KullaniciYazilari extends StatefulWidget {
    @override
    _KullaniciYazilariState createState() => _KullaniciYazilariState();
}

class _KullaniciYazilariState extends State<KullaniciYazilari> {
  var currentUser = FirebaseAuth.instance.currentUser;


  
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
  .collection('Yazilar')
  .where("kullaniciid", isEqualTo  : FirebaseAuth.instance. currentUser?.uid)
 . snapshots() ;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['baslik']),
              subtitle: Text(data['icerik']),
            );
          }).toList(),
        );
      },
    );
  }
} // site kod 



class ProfilTasarimi extends StatefulWidget {
  const ProfilTasarimi({super.key});

  @override
  State<ProfilTasarimi> createState() => _ProfilTasarimiState();
}

class _ProfilTasarimiState extends State<ProfilTasarimi> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
} // geliştir
