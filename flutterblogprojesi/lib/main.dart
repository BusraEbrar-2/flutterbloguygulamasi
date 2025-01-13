import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterblogproject/profilsayfasi.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Iskele (), ); }

}

class Iskele extends StatefulWidget {
  const Iskele({super.key});

  @override
  State<Iskele> createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
 
 TextEditingController t1 = TextEditingController() ;
  TextEditingController t2 = TextEditingController() ;

 Future <void> kayitOl() async {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: t1.text, password: t2.text)
    .then ((kullanici) { // kullanici kayıt işlemi tammalndıktan sonra 
FirebaseFirestore.instance
.collection("kullanıcılar")
.doc(t1.text)
.set({"e posta ": t1. text , "sifre" : t2.text}) ;
    

  }) ;
  
  
  }


  Future<void> girisYap() async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: t1.text, password: t2.text)
      .then( (kullanici) {
    
     /*   Navigator.push(context, // navigator push ile geldiğin sayfada appbar varsa geri butonu otamatik koyuyor 
         MaterialPageRoute (builder  : (context)=> ProfilEkrani(),
          ), 
      );*/
 Navigator.pushAndRemoveUntil ( // Bu yöntem, genellikle kullanıcıyı bir ana sayfaya veya giriş ekranına yönlendirmek ve önceki sayfalara geri dönmesini engellemek için kullanılır.
    context,
  MaterialPageRoute(builder:(_)=> ProfilEkrani() ),
  // yeni sayfa geçişi oluşumu yeni açılcak sayfa 
  (Route<dynamic>route) => false,
//Yığındaki tüm sayfaların kaldırılması gerektiğini söyler.
  );




         }  );
}
        

 // farklı main içinde profil ekranı oluşturup devam et 


 
  @override
  Widget build(BuildContext context) {
    return Scaffold (
body : Container (
margin : EdgeInsets.all(50), 
child : Center (child: Column (
  children: [
     TextField(controller: t1,
  ),
      TextField(controller: t2,
  ),
  Row(children: [
ElevatedButton(onPressed: kayitOl , child: Text ("Kayit Ol ")),
  ElevatedButton(onPressed: girisYap , child: Text ("Giriş Yap ")),
  
  ],
  )

  ],
  ),
  )
)




    );
  }
}