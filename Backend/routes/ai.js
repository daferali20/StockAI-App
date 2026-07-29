const express = require('express');
const router = express.Router();
const { GoogleGenerativeAI } = require('@google/generative-ai');

// Initialize Gemini
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

router.post('/analyze', async (req, res) => {
  try {
    const { symbol, data } = req.body;
    
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });
    
    const prompt = `Analyze stock ${symbol} with data: ${JSON.stringify(data)}. 
                    Provide: 1) Summary 2) Technical analysis 3) Recommendation`;
    
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();
    
    res.json({
      symbol,
      analysis: text,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('AI Analysis Error:', error);
    res.status(500).json({ error: 'AI analysis failed' });
  }
});

router.post('/predict', async (req, res) => {
  try {
    const { symbol, historicalData } = req.body;
    
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });
    
    const prompt = `Predict next day price for ${symbol} based on historical data: ${JSON.stringify(historicalData)}`;
    
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text();
    
    res.json({
      symbol,
      prediction: text,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('AI Prediction Error:', error);
    res.status(500).json({ error: 'AI prediction failed' });
  }
});

module.exports = router;
