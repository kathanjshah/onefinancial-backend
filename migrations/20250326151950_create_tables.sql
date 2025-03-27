-- migrations/<timestamp>_create_watchlist.sql

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL  -- Soft delete field
);

-- Watchlist table with additional fields for tracking modifications and deletions
CREATE TABLE watchList (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,  -- Foreign key to users
    stock_url VARCHAR(255) NOT NULL,  -- Stock URL or symbol
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,  -- Track modifications
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,  -- Soft delete field
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Optional: Index for faster querying by user
CREATE INDEX idx_watchlist_user_id ON watchList(user_id);
