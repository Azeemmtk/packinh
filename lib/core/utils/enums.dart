enum Status { pending, approved, blocked }

extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.pending:
        return 'pending';
      case Status.approved:
        return 'approved';
      case Status.blocked:
        return 'blocked';
    }
  }

  static Status fromString(String status) {
    switch (status) {
      case 'approved':
        return Status.approved;
      case 'blocked':
        return Status.blocked;
      case 'pending':
      default:
        return Status.pending;
    }
  }
}
