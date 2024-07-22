function changePassword(email, newPassword, callback) {
    const bcrypt = require("bcrypt");
   const { Client } = require("pg");
   const connectionString = configuration.DATABASE_URI;
   const client = new Client({
     connectionString: connectionString,
     ssl: {
       rejectUnauthorized: true,
     },
   });
   client.connect((err) => {
     if (err) {
       return callback(err);
     }
  
     bcrypt.hash(newPassword, 10, function (err, hashedPassword) {
       if (err) {
         return callback(err);
       }
  
       const query = `UPDATE "Users" SET "password" = $1 WHERE "email" = $2`;
       client.query(query, [hashedPassword, email], function (err, result) {
         if (err) {
           return callback(err);
         }
         return callback(null, true);
       });
     });
   });
  }
  