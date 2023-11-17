admin = User.create_with(name: 'Admin', role: :admin, password: "Password").find_or_create_by(email: "admin@nxtsolutions.com")
user = User.create_with(name: 'User', role: :user, password: "Password").find_or_create_by(email: "user@nxtsolutions.com")

room_types_data = [
  {
    name: "Main Room",
    description: "Room's description",
    max_adult: 4,
    price_per_night: 200,
    available_rooms: 10
  }, {
    name: "Single Room",
    description: "Room's description",
    max_adult: 1,
    price_per_night: 100,
    available_rooms: 4
  }, {
    name: "Twin Room",
    description: "Room's description",
    max_adult: 2,
    max_kids: 2,
    price_per_night: 300,
    available_rooms: 6
  }, {
    name: "Sea view Room",
    description: "Room's description",
    max_adult: 3,
    max_kids: 2,
    price_per_night: 500,
    available_rooms: 5
  },
]

admin.room_types.create!(room_types_data) if RoomType.count.zero?