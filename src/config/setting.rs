use dotenv::dotenv;
use std::env;


pub struct Settings {
    database_url: String,
    host: String,
    port: u16,
}

//All Functions with &self self or &mut self as first parameters are called Methods. Methods are called by `.` dot notation (Method call notation)
//All Funcitons without that are Associated funcitons. Assocaited Functions are called by `::` path notation. (usually used for constructor methods) new, get, set
impl Settings {
    pub fn new() -> Self {
        dotenv().ok();

        Self {
            database_url: env::var("DATABASE_URL").expect("DATABASE_URL must be set in env"),
            host: env::var("HOST").expect("HOST must be set in env"),
            port: env::var("PORT").parse::<u16>().expect("Invalid Port"),
        }
    }
}
