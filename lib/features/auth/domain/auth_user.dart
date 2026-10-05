/// Domain model representing an authenticated user.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.isAnonymous = false,
  });

  final String id;
  final String email;
  final String? name;
  final bool isAnonymous;

  String get displayName {
    if (name != null && name!.trim().isNotEmpty) {
      return name!;
    }
    return email.split('@').first;
  }

  String get initials {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return displayName
        .substring(0, displayName.length >= 2 ? 2 : 1)
        .toUpperCase();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;

  @override
  String toString() => 'AuthUser(id: $id, email: $email, name: $name)';
}
