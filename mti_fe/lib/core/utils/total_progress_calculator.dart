class TotalProgressCalculator {
  static double calculateMilestoneProgress(List<Map<String, dynamic>> data) {
    double totalAnswered = 0;
    double totalQuestionsSum = 0;

    for (var item in data) {
      var progress = item['progress'] ?? {};
     
      double totalQuestions = (progress['totalQuestions'] ?? 0).toDouble();
      double totalAnsweredYes = (progress['answeredYes'].length ?? 0).toDouble();
      double totalAnsweredNo = (progress['answeredNo'].length ?? 0).toDouble();

      totalAnswered += (totalAnsweredYes + totalAnsweredNo);
      totalQuestionsSum += totalQuestions;
    }

    return totalQuestionsSum > 0 ? totalAnswered / totalQuestionsSum : 0.0;
  }
}
