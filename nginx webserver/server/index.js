const express = require("express");

const app = express();

// Define a route for the GET request
app.get("/", (req, res) => {
  const containerName = process.env.CONTAINER_NAME || "Unknown Container";
  res.send(`Hi from ${containerName}`);
});

// Start the server on port 7777
app.listen(7777, () => {
  console.log("Server is running on port 7777");
});
