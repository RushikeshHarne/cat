-- Create the database
CREATE DATABASE IF NOT EXISTS user_db;

-- Switch to the user_db database
USE user_db;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user_profiles table (for the dashboard/save_profile functionality)
CREATE TABLE IF NOT EXISTS user_profiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT AUTO_INCREMENT,
    full_name VARCHAR(100),
    preferred_role VARCHAR(100),
    skills TEXT,
    linkedin VARCHAR(255),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create root user with privileges (if needed)
-- Note: In production, you should use a more secure password
GRANT ALL PRIVILEGES ON user_db.* TO 'root'@'localhost' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
