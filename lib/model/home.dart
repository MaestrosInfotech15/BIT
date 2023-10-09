class Home {
  String? title;
  String? page;
  String? image;

  Home({this.title, this.image, this.page});

  static List<Home> homeList = [

    Home(title: 'Influencers',image: 'akshay.png'),
    Home(title: 'Singers',image: 'singer.png'),
    Home(title: 'News Anchor',image: 'news_anchor.png'),
    Home(title: 'Gym',image: 'gym.png'),
    Home(title: 'Cameraman',image: 'selfie.png'),
    Home(title: 'Voice Over',image: 'voiceover_artist.png'),
    Home(title: 'Hair Stylist',image: 'hair_stylist.png'),
    Home(title: 'Yoga',image: 'yoga.png'),
    Home(title: 'Reporter',image: 'reporter.png'),
  ];
}
