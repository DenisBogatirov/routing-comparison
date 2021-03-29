class UserRoutePath {
  final String id;
  final bool isUnknown;

  UserRoutePath.users()
      : id = null,
        isUnknown = false;

  UserRoutePath.details(this.id) : isUnknown = false;

  UserRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isUsersPage => id == null;

  bool get isDetailsPage => id != null;
}
