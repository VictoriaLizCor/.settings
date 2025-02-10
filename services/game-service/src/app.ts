import express from 'express';
import http from 'http';
import WebSocket from 'ws';

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

app.use(express.json());

// Endpoint to create a game
app.post('/games', (req, res) => {
    // Logic to create a game
    res.status(201).send({ message: 'Game created' });
});

// Endpoint to get game status
app.get('/games/:id', (req, res) => {
    const gameId = req.params.id;
    // Logic to get game status
    res.send({ gameId, status: 'In Progress' });
});

// WebSocket connection for real-time updates
wss.on('connection', (ws) => {
    console.log('New client connected');

    ws.on('message', (message) => {
        // Logic to handle incoming messages
        console.log(`Received message: ${message}`);
    });

    ws.on('close', () => {
        console.log('Client disconnected');
    });
});

// Start the server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Game service running on port ${PORT}`);
});