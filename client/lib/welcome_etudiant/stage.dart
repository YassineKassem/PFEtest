class Job {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;
  List<String> req;

  Job(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.time, this.req);

  static List<Job> generateJobs() {
    return [
      Job(
        'Medianet',
        'assets/images/google_logo.png',
        true,
        'stage developpement',
        'location',
        'full time',
        [
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
              's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries'
              ' but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages'
              'and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
        ],
      ),
      Job(
        'Medianet',
        'assets/images/google_logo.png',
        false,
        'stage developpement',
        'location',
        'full time',
        [
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
              's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries'
              ' but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages'
              'and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
        ],
      ),
      Job(
        'Medianet',
        'assets/images/google_logo.png',
        false,
        'stage developpement',
        'location',
        'full time',
        [
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
              's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries'
              ' but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages'
              'and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
        ],
      ),
    ];
  }
}
