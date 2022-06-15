class Statistics {
  Statistics({
    this.viewCount,
  });

  String viewCount;
 

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        viewCount: json["viewCount"],
      
      );

  Map<String, dynamic> toJson() => {
        "viewCount": viewCount,
      
      };
}
