class Team {
  String name;
  String desc;
  String job;
  String image;
  String speciality;
  String fbUrl;
  String twitterUrl;
  String linkedinUrl;
  String githubUrl;
  String contribution;

  Team(
      {this.name,
      this.desc,
      this.job,
      this.image,
      this.speciality,
      this.fbUrl,
      this.twitterUrl,
      this.linkedinUrl,
      this.githubUrl,
      this.contribution});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    desc = json['desc'];
    job = json['job'];
    image = json['image'];
    speciality = json['speciality'];
    fbUrl = json['fb_url'];
    twitterUrl = json['twitter_url'];
    linkedinUrl = json['linkedin_url'];
    githubUrl = json['github_url'];
    contribution = json['contribution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['job'] = this.job;
    data['image'] = this.image;
    data['speciality'] = this.speciality;
    data['fb_url'] = this.fbUrl;
    data['twitter_url'] = this.twitterUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['github_url'] = this.githubUrl;
    data['contribution'] = this.contribution;
    return data;
  }
}

List<Team> teams = [
  Team(
    name: "Parth Jansari",
    desc: "Organizer",
    contribution: "Lead at GDG Gandhinagar",
    image:
        "https://github.com/parth181195.png",
  ),
  Team(
    name: "Aashutosh Rathi",
    desc: "Organizer",
    contribution: "Lead at IIITV",
    image:
        "https://github.com/aashutoshrathi.png",
  ),
  Team(
    name: "Jay Mistry",
    desc: "Organizer",
    contribution: "Sec at IIITV Coding Club",
    image:
        "https://github.com/rossoskull.png",
  ),
  Team(
    name: "Pushkar Patel",
    desc: "Organizer",
    contribution: "J Sec at IIITV Coding Club",
    image:
        "https://github.com/thepushkarp.png",
  ),
];
