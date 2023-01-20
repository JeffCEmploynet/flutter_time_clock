class DayPunches {
  final String punchIn;
  final String lunchOut;
  final String lunchIn;
  final String punchOut;

  DayPunches(this.punchIn, this.lunchOut, this.lunchIn, this.punchOut);

  DayPunches.fromJson(Map<String, dynamic> json)
    : punchIn= json['punchIn'],
      lunchOut = json['lunchOut'],
      lunchIn = json['lunchIn'],
      punchOut = json['punchOut'];

  Map<String, dynamic> toJson() => {
    'punchIn': punchIn,
    'lunchOut': lunchOut,
    'lunchIn': lunchIn,
    'punchOut': punchOut,
  };
}