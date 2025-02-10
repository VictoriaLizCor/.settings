const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Pool } = require('pg'); // Assuming PostgreSQL is used

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Database connection
const pool = new Pool({
    user: 'your_db_user',
    host: 'your_db_host',
    database: 'your_db_name',
    password: 'your_db_password',
    port: 5432,
});

// API routes
app.get('/api/data', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM your_table');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Server error');
    }
});

// Start server
app.listen(port, () => {
    console.log(`Backend service running on port ${port}`);
});