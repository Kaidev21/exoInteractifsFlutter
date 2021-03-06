class Profile {

  String surname;
  String name;
  int age;
  bool gender;
  double height;
  String secret;
  List<String> hobbies = [];
  String favoriteLang;

  Profile({
    this.surname = "",
    this.name = "",
    this.age = 0,
    this.gender = true,
    this.height = 50.0,
    this.secret = "",
    this.hobbies = const [],
    this.favoriteLang ="Dart"
  });

  String setName() => '$surname $name';
  String setAge() {
    String ageString = "$age an";
    if(age>1) {
      ageString += "s";
    }
    return ageString;
  }

  String genderString() => (gender) ? "Féminin" : "Masculin";

  String setHeight () => "${height.toStringAsFixed(2)} cm";

  String setHobbies() {
    String toHobbiesString = "";
    if(hobbies.length == 0) {
      return toHobbiesString;
    } else {
      toHobbiesString = "";
      hobbies.forEach((hobbie) {
        toHobbiesString = '$hobbies, ';
      });
      return toHobbiesString;
    }
  }
}