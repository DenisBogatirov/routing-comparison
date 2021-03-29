import 'package:meta/meta.dart';

const _userList = [
  {
    "name": {"title": "Miss", "first": "Isobel", "last": "Gilbert"},
    "email": "isobel.gilbert@example.com",
    "id": {"name": "SSN", "value": "463-15-9740"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/72.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/72.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/72.jpg"
    }
  },
  {
    "name": {"title": "Ms", "first": "Georgia", "last": "Graham"},
    "email": "georgia.graham@example.com",
    "id": {"name": "SSN", "value": "118-48-6390"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/26.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/26.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/26.jpg"
    }
  },
  {
    "name": {"title": "Miss", "first": "Peyton", "last": "Crawford"},
    "email": "peyton.crawford@example.com",
    "id": {"name": "SSN", "value": "853-48-9669"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/74.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/74.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/74.jpg"
    }
  },
  {
    "name": {"title": "Ms", "first": "Patsy", "last": "Ellis"},
    "email": "patsy.ellis@example.com",
    "id": {"name": "SSN", "value": "414-02-1027"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/94.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/94.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/94.jpg"
    }
  },
  {
    "name": {"title": "Miss", "first": "Shannon", "last": "Reyes"},
    "email": "shannon.reyes@example.com",
    "id": {"name": "SSN", "value": "540-28-9262"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/38.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/38.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/38.jpg"
    }
  },
  {
    "name": {"title": "Mrs", "first": "Phyllis", "last": "Young"},
    "email": "phyllis.young@example.com",
    "id": {"name": "SSN", "value": "050-17-1987"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/49.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/49.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/49.jpg"
    }
  },
  {
    "name": {"title": "Miss", "first": "Eva", "last": "Stewart"},
    "email": "eva.stewart@example.com",
    "id": {"name": "SSN", "value": "853-72-5026"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/80.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/80.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/80.jpg"
    }
  },
  {
    "name": {"title": "Mrs", "first": "Debbie", "last": "Phillips"},
    "email": "debbie.phillips@example.com",
    "id": {"name": "SSN", "value": "823-82-3311"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/50.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/50.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/50.jpg"
    }
  },
  {
    "name": {"title": "Miss", "first": "Clara", "last": "Smith"},
    "email": "clara.smith@example.com",
    "id": {"name": "SSN", "value": "023-55-0822"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/89.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/89.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/89.jpg"
    }
  },
  {
    "name": {"title": "Mrs", "first": "Dawn", "last": "Cook"},
    "email": "dawn.cook@example.com",
    "id": {"name": "SSN", "value": "449-68-0901"},
    "picture": {
      "large": "https://randomuser.me/api/portraits/women/53.jpg",
      "medium": "https://randomuser.me/api/portraits/med/women/53.jpg",
      "thumbnail": "https://randomuser.me/api/portraits/thumb/women/53.jpg"
    }
  }
];

class User {
  final String id;
  final String name;
  final String email;
  final String avatar;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.avatar,
  })  : assert(id != null),
        assert(name != null),
        assert(email != null),
        assert(avatar != null);
}

final Map<String, User> _users = _userList.fold({}, (map, json) {
  final Map<String, String> id = json["id"];
  final Map<String, String> name = json["name"];
  final Map<String, String> picture = json["picture"];

  final user = User(
    id: id["value"],
    name: '${name["first"]} ${name["last"]}',
    avatar: picture["large"],
    email: json["email"],
  );

  map[user.id] = user;

  return map;
});

// _userList.forEach((json) {

// });

class UserService {
  User getById(String id) => _users[id];
  List<User> getUsers() => _users.values.toList();
  List<User> getFriendsById(String id) => _users.values.where((user) => user.id != id).toList();
}
