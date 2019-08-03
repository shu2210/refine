/*
 * Usage
 *  mongo log fluentd-users.js -u root -p password --authenticationDatabase admin
 * */

// User definitions to register
var newUsers = [
  {
    user: 'logger',
    pwd: 'logger',
    roles: [
      {
        role: 'readWrite',
        db: 'log'
      }
    ]
  },
  {
    user: 'fluentd',
    pwd: 'fluentd',
    roles: [
      {
        role: 'dbOwner',
        db: 'log'
      }
    ]
  }
];

// Check if initial settings are done
var currentUsers = db.getUsers();
if (currentUsers.length === newUsers.length) {
    quit();
}

// Drop users for database
db.dropAllUsers();

// Add users
for (var i = 0, length = newUsers.length; i < length; ++i) {
    db.createUser(newUsers[i]);
}
