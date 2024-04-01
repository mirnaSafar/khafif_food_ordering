class PaginationModel {
  int? total;
  int? perPage;
  int? currentPage;
  dynamic nextPage;
  int? totalPages;

  PaginationModel(
      {this.total,
      this.perPage,
      this.currentPage,
      this.nextPage,
      this.totalPages});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    perPage = json["per_page"];
    currentPage = json["current_page"];
    nextPage = json["next_page"];
    totalPages = json["total_pages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["total"] = total;
    data["per_page"] = perPage;
    data["current_page"] = currentPage;
    data["next_page"] = nextPage;
    data["total_pages"] = totalPages;
    return data;
  }
}
