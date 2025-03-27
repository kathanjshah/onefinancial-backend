use actix_web::{get, web ,HttpResponse, App, HttpServer, Responder};
use sqlx::PgPool;
use dotenvy::dotenv;
use std::env;

#[get("/")]
async fn health_check() -> impl Responder {
    HttpResponse::Ok().body("OneFinancial API is running!")
}

async fn establish_connection() -> PgPool {
    // Load environment variables from .env file
    dotenv().ok();
    
    // Get the DATABASE_URL from environment variables
    let database_url = env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set in the .env file");
    
    // Establish the PostgreSQL connection pool
    let pool = PgPool::connect(&database_url)
        .await
        .expect("Failed to connect to the database");
    
    pool
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Establish the database connection
    let pool = establish_connection().await;

    println!("Successfully connected to the database!");

    // Start the Actix web server
    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone())) // Pass the pool to your handlers
            .service(health_check)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
