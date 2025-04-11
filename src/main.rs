mod config;

use actix_web::{get, web, HttpResponse, App, HttpServer, Responder};
use crate::config::db_connection::establish_connection; // Import the establish_connection function

#[get("/")]
async fn health_check() -> impl Responder {
    HttpResponse::Ok().body("OneFinancial API is running!")
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
