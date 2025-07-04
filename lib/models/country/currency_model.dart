class CurrencyModel {
    final String alpha;

    CurrencyModel({
        required this.alpha,
    });

    factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        alpha: json["alpha"],
    );

    Map<String, dynamic> toJson() => {
        "alpha": alpha,
    };
}