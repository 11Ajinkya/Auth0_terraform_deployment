function create(user, callback) {
  console.log("In Create");

  const bcrypt = require("bcrypt");
  const { Client } = require("pg");
  const connectionString = configuration.DATABASE_URI;
  const userMetadata = user.user_metadata;
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

    bcrypt.hash(user.password, 10, function (err, hashedPassword) {
      if (err) {
        return callback(err);
      }
      const query = `INSERT INTO "Users" ("firstName", "lastName", "email", "password", "phoneNumber", "isActive", "NMLS", "organisationNMLS", "isOrganisation", "isVerified") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)`;
      client.query(
        query,
        [
          userMetadata.firstName,
          userMetadata.lastName,
          user.email,
          hashedPassword,
          userMetadata.phoneNumber,
          1,
          userMetadata.NMLS,
          userMetadata.organisationNMLS,
          userMetadata.isOrganisation === "true" ? 1 : 0,
          0,
        ],
        function (err, result) {
          return callback(null, result);
        }
      );
    });
  });
}
