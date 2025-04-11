use std::env;
use dotenvy::dotenv;
use sqlx::PgPool;

pub async fn establish_connection() -> PgPool {
    // Load environment variables from .env file
    dotenv().ok();
    
    // Get the DATABASE_URL from environment variables
    let database_url: String = env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set in the .env file");
    
    // Establish the PostgreSQL connection pool
    let pool = PgPool::connect(&database_url)
        .await
        .expect("Failed to connect to the database");
    
    pool
}