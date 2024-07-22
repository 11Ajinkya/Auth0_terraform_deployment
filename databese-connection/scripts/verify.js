function verify(email, callback) {
    console.log('verify', email);
    // Implement logic to mark the user's email as verified in your database
    const { Client } = require('pg');
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
  
      const query = `
        UPDATE "Users"
           SET "isVerified" = $1::bit
            WHERE "email" = $2
      `;
      client.query(query, [1, email], (err) => {
        console.log(email, err);
        if (err) {
          return callback(err);
        }
  
        callback(null, true); // Email verification successful
      });
    });
  }
  
  