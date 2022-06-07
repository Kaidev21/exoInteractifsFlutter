import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  Profile myProfile = Profile();
  late TextEditingController surnameController;
  late TextEditingController nameController;
  late TextEditingController secretController;
  late TextEditingController ageController;
  bool showSecret = false;
  Map<String, bool> hobbies = {
    "Football" : false,
    "BasketBall" : false,
    "e-games" : false,
    "Mangas" : false,
    "Code" : false
  };

  @override
  void initState() {
    super.initState();
    surnameController = TextEditingController();
    nameController = TextEditingController();
    secretController = TextEditingController();
    ageController = TextEditingController();
    surnameController.text = myProfile.surname;
    nameController.text = myProfile.name;
    secretController.text = myProfile.secret;
    ageController.text = myProfile.age.toString();
  }

  @override
  void dispose() {
    surnameController.dispose();
    nameController.dispose();
    secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(title: Text("Mon profil"),),
      body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: informations(width/0.2, height/3.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_album),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_enhance),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
                color: Colors.purple,
              ),
              const Text("Modifier les infos",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.2,
              ),
              Container(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        icon: const Icon(Icons.person),
                        hintText: "Entrez votre nom",
                        labelText: "Nom",
                      ),
                      onFieldSubmitted: ((newValue) {
                        updateUser();
                      }),
                    ),
                    TextFormField(
                      controller: surnameController,
                      decoration: const InputDecoration(
                        filled: true,
                        icon: const Icon(Icons.person),
                        hintText: "Entrez votre prénom",
                        labelText: "Prénom",
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          updateUser();
                        });
                      },
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        filled: true,
                        icon: const Icon(Icons.accessibility_new),
                        hintText: "Entrez votre âge",
                        labelText: "Âge"
                      ),
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) {
                        setState((){
                          updateUser();
                        });
                      },
                    ),
                    TextFormField(
                      controller: secretController,
                      decoration: const InputDecoration(
                        filled: true,
                        icon: const Icon(Icons.lock_outline_rounded),
                        hintText: "Dites nous un secret",
                        labelText: "Votre secret",
                      ),
                      obscureText: true,
                      onFieldSubmitted: (value) {
                        setState(() {
                          updateUser();
                        });
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Genre: ${myProfile.genderString()}"),
                        Switch(
                            value: myProfile.gender,
                            onChanged: ((value) {
                              setState(() {
                                myProfile.gender = value;
                              });
                            })
                        )
                      ],
                    ),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Taille: ${myProfile.setHeight()}"),
                          Slider(
                              value: myProfile.height,
                              min: 50,
                              max: 300,
                              onChanged: ((value) {
                                setState(() {
                                  myProfile.height = value;
                                });
                              })
                          )
                        ]),
                    const Divider(
                      thickness: 2,
                      color: Colors.purple,
                    ),
                    const Text("Modifier les infos",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    myHobbies(),
                    const Divider(
                      thickness: 2,
                      color: Colors.purple,
                    ),
                    const Text("Langage préféré",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    myRadios(),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  updateUser() {
    setState((){
      myProfile =  Profile (
        surname: (surnameController.text != myProfile.surname) ? surnameController.text:surnameController.text,
        name: (nameController.text != myProfile.name) ? nameController.text : myProfile.name,
        secret: secretController.text,
        favoriteLang: myProfile.favoriteLang,
        hobbies: myProfile.hobbies,
        height: myProfile.height,
        age: int.parse(ageController.text
        ),
        gender: myProfile.gender
      );
    });
  }

  updateSecret() {
    setState(() {
      showSecret = !showSecret;
    });
  }

  Container informations (double width, double height) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(160, 95, 194, 5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Nom: ${myProfile.setName()}"),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (image == null) ? Text("Aucune Image") :
              Image.file(File(image!.path), height: height/2, width: 200),
              Column(
                children: [
                  Text("Age: " + myProfile.setAge()),
                  Text("Taille: " + myProfile.setHeight()),
                  Text("Genre: " + myProfile.genderString()),
                ],
              )
            ],
          ),

          Text("Hobbies: " + myProfile.setHobbies()),

          Text("Langage de programmation favori: " + myProfile.favoriteLang),
          ElevatedButton(
            onPressed: () {
              updateSecret();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                elevation: 10,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                )
            ),
            child: Text((showSecret)? "Cacher secret" : "Montrer secret"),
          ),
          (showSecret)? Text(myProfile.secret) : Container(height: 0, width: 0,)
        ],
      ),
    );
  }

  Column myHobbies() {
    List<Widget> widgets = [];
    hobbies.forEach((hobby, like) {
    Row r = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(hobby),
              Checkbox(value: like, onChanged: (newBool){
                setState((){
                  hobbies[hobby] = newBool ?? false;
                  List<String> str = [];
                  hobbies.forEach((key, value) {
                    if(value) {
                      str.add(key);
                    }
                  });
                  myProfile.hobbies = str;
                });
              })
            ],
      );
          widgets.add(r);
    });
    return Column(children: widgets);
  }

  Row myRadios() {
    List<Widget> w = [];
    List<String> langs = ["Dart", "Swift", "Kotlin", "Java", "Python"];
    int index = langs.indexWhere((lang) => lang.startsWith(myProfile.favoriteLang));
    for(var x = 0; x < langs.length; x++) {
      Column c = Column (
        children: [
          Text(langs[x]),
          Radio(value: x, groupValue: index, onChanged: (newValue) {
            setState(() {
              myProfile.favoriteLang = langs[newValue as int];
            });
          },)
        ],
      );
      w.add(c);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: w,
    );
  }

  Future pickImage(ImageSource source) async {
     XFile? pickedImage = await _picker.pickImage(source: source);
     setState((){
       if(pickedImage == null) {
         print("Nous n'avons pas pu récupérer d'image");
       } else {
         image = pickedImage;
         print(image?.name);
       }
     });
  }

}