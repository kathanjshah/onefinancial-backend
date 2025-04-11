-- Add down migration script here
-- migrations/<timestamp>_down_create_users_watchlist_habits_and_entries.sql

-- Drop indexes created in the 'up' migration
DROP INDEX IF EXISTS idx_watchlist_user_id;
DROP INDEX IF EXISTS idx_habit_entries_habit_id;
DROP INDEX IF EXISTS idx_habits_user_id;

-- Drop the 'habit_entries' table
DROP TABLE IF EXISTS habit_entries;

-- Drop the 'habits' table
DROP TABLE IF EXISTS habits;

-- Drop the 'watchlist' table
DROP TABLE IF EXISTS watchList;

-- Drop the 'users' table
DROP TABLE IF EXISTS users;
