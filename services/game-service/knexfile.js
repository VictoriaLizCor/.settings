module.exports = {
  client: 'pg',
  connection: {
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'game_sessions_db'
  },
  migrations: {
    tableName: 'knex_migrations'
  }
};