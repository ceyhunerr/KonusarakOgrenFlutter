class episodeModel {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  String? url;
  String? created;
  List<dynamic>? charList;

  episodeModel(
      {required this.id,
        required this.name,
        required this.airDate,
        required this.episode,
        required this.url,
        required this.created,
        required this.charList});

}