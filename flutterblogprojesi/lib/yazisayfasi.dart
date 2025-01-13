import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YaziEkrani extends StatefulWidget {
  const YaziEkrani({super.key});

  @override
  State<YaziEkrani> createState() => _YaziEkraniState();
}

class _YaziEkraniState extends State<YaziEkrani> {
 
 TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
 
 var gelenYaziBasligi = "";
 var gelenYaziIcerigi = "";

var currentUser = FirebaseAuth.instance.currentUser;


 yaziEkle(){
FirebaseFirestore.instance  // veri tabanı bağlantı kurmak 
.collection("Yazilar") // koleksiyonu seçtim
.doc(t1.text) // belge kimliği 
.set({'kullaniciid' : currentUser?.uid,      'baslik':t1.text,'icerik':t2.text} )
.whenComplete(   () => print("yazi eklendi ") ); 
 // bilgi güncelleme


 }
  yaziGuncelle(){
FirebaseFirestore.instance  // veri tabanı bağlantı kurmak 
.collection("Yazilar") // koleksiyonu seçtim
.doc(t1.text) // belge kimliği 
.set({'baslik':t1.text,'icerik':t2.text} )
.whenComplete(() => print("yazi guncellendi "));
 }
 // bilgi güncelleme

yaziSil(){
  FirebaseFirestore.instance
  .collection("Yazilar")
  .doc(t1.text) 
.delete();
}

  yaziGetir(){
FirebaseFirestore.instance  // veri tabanı bağlantı kurmak 
.collection("Yazilar") // koleksiyonu seçtim
.doc(t1.text) // belge kimliği 
.get()
.then( (gelenVeri){
  setState((){
   // Null kontrolü ile erişim
      gelenYaziIcerigi = gelenVeri.data()?['icerik'] ?? "İçerik yok";
      gelenYaziBasligi = gelenVeri.data()?['baslik'] ?? "Başlık yok";
  }
  ) ;

} );
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title:Text("Yazı Ekranı") ,) ,
      body : Container(
        margin: EdgeInsets.all(40),
        child:Center (
          child: 
        Column (
          children: [
          TextField(
          controller: t1,
           ),
TextField(
          controller: t2,
           ),
Row( children: [
   ElevatedButton(
          onPressed: yaziEkle,
          child: Text("Yazı Ekle"),
        ),
        ElevatedButton(
          onPressed: yaziGuncelle,
          child: Text("Yazı Güncelle"),
        ),
        ElevatedButton(
          onPressed: yaziSil,
          child: Text("Yazı Sil"),
        ),
        ElevatedButton(
          onPressed: yaziGetir,
          child: Text("Yazı Getir"), 

),



        ],
        ),
ListTile(
title : Text (gelenYaziBasligi),
subtitle: Text(gelenYaziIcerigi),
),

        ],
        ),),

      ),
    );
  }}