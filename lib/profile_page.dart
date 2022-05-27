import 'package:flutter/material.dart';

import 'profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  Profile myProfile = Profile();
  late TextEditingController surnameController;
  late TextEditingController nameController;
  late TextEditingController secretController;
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
    surnameController.text = myProfile.surname;
    nameController.text = myProfile.name;
    secretController.text = myProfile.secret;
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
                height: height /2,
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
                    myHobbies(),
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
        secret: secretController.text
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
          Text("Age: " + myProfile.setAge()),
          Text("Taille: " + myProfile.setHeight()),
          Text("Hobbies: " + myProfile.setHobbies()),
          Text("Genre: " + myProfile.genderString()),
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

}