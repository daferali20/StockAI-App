const express = require('express');
const router = express.Router();

// Mock authentication
router.post('/login', (req, res) => {
  const { username, password } = req.body;
  
  if (username === 'demo' && password === 'demo123') {
    res.json({
      token: 'mock-jwt-token',
      user: { id: 1, username: 'demo' }
    });
  } else {
    res.status(401).json({ error: 'Invalid credentials' });
  }
});

router.post('/register', (req, res) => {
  const { username, email, password } = req.body;
  
  // Mock registration
  res.status(201).json({
    message: 'User registered successfully',
    user: { id: 2, username, email }
  });
});

module.exports = router;
