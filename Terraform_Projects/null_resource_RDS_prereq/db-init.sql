-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS nikhil;
USE nikhil;

-- Check if the table already exists before creating it
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Drop the user if it already exists, then create a new user and grant privileges
DROP USER IF EXISTS 'appuser'@'%';
CREATE USER 'appuser'@'%' IDENTIFIED BY 'AppUser123!';
GRANT ALL PRIVILEGES ON nikhil.* TO 'appuser'@'%';  -- Corrected to 'nikhil'
FLUSH PRIVILEGES;

-- Insert sample data into the users table
INSERT INTO users (name, email) VALUES 
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Brown', 'bob.brown@example.com');

-- Check if rows were inserted
SELECT * FROM users;
