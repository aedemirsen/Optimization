class Profile {
  int? boy, gram, adet;
  String? profilKod;

  //key: profil uzunluğu
  //value: adet
  Profile(int boy, String id, int adet) {
    boy = boy;
    profilKod = id;
    adet = adet;
  }

  int toplam() {
    return boy! * adet!;
  }
}
