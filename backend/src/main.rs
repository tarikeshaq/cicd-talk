use actix_web::{get, middleware, App, Error, HttpResponse, HttpServer};

#[macro_use]
extern crate diesel;
use diesel::prelude::*;
use diesel::r2d2::ConnectionManager;
mod schema;

#[get("/")]
async fn hello_world() -> Result<HttpResponse, Error> {
    Ok(HttpResponse::Ok().body("Hello world!"))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    std::env::set_var("RUST_LOG", "actix_web=info");
    env_logger::init();
    dotenv::dotenv().ok();

    let connspec = std::env::var("DATABASE_URL").expect("Database url not provided");
    let manager = ConnectionManager::<PgConnection>::new(connspec);
    let pool = r2d2::Pool::builder()
        .build(manager)
        .expect("Failed to create database pool");

    let bind = std::env::var("BIND").expect("bind string not provided, should be given as IP:PORT");
    println!("Starting server at: {}", bind);

    HttpServer::new(move || {
        App::new()
            .data(pool.clone())
            .wrap(middleware::Logger::default())
            .service(hello_world)
        //TODO: Add services here
    })
    .bind(&bind)?
    .run()
    .await
}
