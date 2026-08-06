enum DocumentType { passport, visa, vaccination, other }
enum DocumentStatus { pending, verified, rejected }

class HajjDocument {
  final String id;
  final String title;
  final DocumentType type;
  final String url;
  final DocumentStatus status;

  HajjDocument({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    required this.status,
  });
}
