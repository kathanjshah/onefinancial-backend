-- Add up migration script here

-- migrations/<timestamp>_create_users_watchlist_habits_and_entries.sql

-- Create the 'users' table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL  -- Soft delete field
);

-- Create the 'watchlist' table
CREATE TABLE watchList (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,  -- Foreign key to users
    stock_url VARCHAR(255) NOT NULL,  -- Stock URL or symbol
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,  -- Track modifications
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,  -- Soft delete field
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create the 'habits' table
CREATE TABLE habits (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,  -- Foreign key to users
    name VARCHAR(255) NOT NULL,  -- Name of the habit
    description TEXT,  -- Description of the habit
    frequency JSONB,  -- JSON structure for frequency, e.g., {"type": "daily"} or {"type": "weekly", "days": ["Monday", "Friday"]}
    color VARCHAR(7),  -- Color (e.g., HEX color like "#FF5733")
    icon_name VARCHAR(255),  -- Icon name (e.g., "running", "book", "meditation")
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,  -- Track modifications
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL  -- Soft delete field
);

-- Create the 'habit_entries' table
CREATE TABLE habit_entries (
    id SERIAL PRIMARY KEY,
    habit_id INT REFERENCES habits(id) ON DELETE CASCADE,  -- Foreign key to habits
    date DATE NOT NULL,  -- Date for the specific habit entry
    progress INT DEFAULT 0,  -- Progress: 0 = not done, 50 = partial, 100 = complete
    notes TEXT,  -- Optional notes about the habit for that day
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP  -- Timestamp of record creation
);

-- Optional: Create indexes for better query performance
CREATE INDEX idx_watchlist_user_id ON watchList(user_id);
CREATE INDEX idx_habit_entries_habit_id ON habit_entries(habit_id);
CREATE INDEX idx_habits_user_id ON habits(user_id);
