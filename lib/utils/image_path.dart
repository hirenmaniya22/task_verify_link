class ImagePath {
  static createPath(String name) => 'assets/images/$name';

  static final String facebookIcon = createPath('facebook_icon.png');
  static final String instagramIcon = createPath('instagram_icon.png');
  static final String twitterIcon = createPath('twitter_icon.png');
  static final String defaultPersonIcon = createPath('person_icon.png');
}