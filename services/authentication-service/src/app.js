const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;
const SECRET_KEY = process.env.SECRET_KEY || 'your_secret_key';

app.use(cors());
app.use(bodyParser.json());

let users = []; // This should be replaced with a database in a production environment

app.post('/register', async (req, res) => {
    const { username, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    users.push({ username, password: hashedPassword });
    res.status(201).send('User registered');
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    const user = users.find(u => u.username === username);
    if (user && await bcrypt.compare(password, user.password)) {
        const token = jwt.sign({ username }, SECRET_KEY);
        res.json({ token });
    } else {
        res.status(401).send('Invalid credentials');
    }
});

app.get('/protected', (req, res) => {
    const token = req.headers['authorization'];
    if (!token) return res.sendStatus(403);
    
    jwt.verify(token, SECRET_KEY, (err, user) => {
        if (err) return res.sendStatus(403);
        res.json({ message: 'Protected data', user });
    });
});

app.listen(PORT, () => {
    console.log(`Authentication service running on port ${PORT}`);
});