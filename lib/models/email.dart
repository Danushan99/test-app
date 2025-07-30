class Email {
  final int id;
  final String toEmail;
  final String subject;
  final String message;
  final String sentAt;

  Email({
    required this.id,
    required this.toEmail,
    required this.subject,
    required this.message,
    required this.sentAt,
  });

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'],
      toEmail: json['to_email'],
      subject: json['subject'],
      message: json['message'],
      sentAt: json['sent_at'],
    );
  }
}
