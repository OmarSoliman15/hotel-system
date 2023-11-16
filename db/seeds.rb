User.create_with(name: 'Admin', role: :admin, password: "Password").find_or_create_by(email: "admin@nxtsolutions.com")
User.create_with(name: 'User', role: :user, password: "Password").find_or_create_by(email: "user@nxtsolutions.com")
