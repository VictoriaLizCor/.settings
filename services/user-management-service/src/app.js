const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// User data storage (in-memory for simplicity)
let users = [];

// User registration
app.post('/register', (req, res) => {
    const { username, password } = req.body;
    // Implement validation and registration logic here
    users.push({ username, password });
    res.status(201).send({ message: 'User registered successfully' });
});

// User login
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    // Implement login logic here
    const user = users.find(u => u.username === username && u.password === password);
    if (user) {
        res.send({ message: 'Login successful' });
    } else {
        res.status(401).send({ message: 'Invalid credentials' });
    }
});

// Manage user preferences
app.put('/user/preferences', (req, res) => {
    const { username, preferences } = req.body;
    // Implement logic to update user preferences here
    res.send({ message: 'User preferences updated' });
});

// Start the server
app.listen(PORT, () => {
    console.log(`User Management Service running on port ${PORT}`);
});