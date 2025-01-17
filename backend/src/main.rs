use actix_web::{get, middleware, web, App, Error, HttpResponse, HttpServer};
use diesel::prelude::*;
use diesel::r2d2::ConnectionManager;
type DbPool = r2d2::Pool<ConnectionManager<PgConnection>>;
use backend::actions;

#[get("/courses")]
async fn get_all_courses(pool: web::Data<DbPool>) -> Result<HttpResponse, Error> {
    let conn = pool
        .get()
        .map_err(|_| HttpResponse::InternalServerError().finish())?;
    let courses = web::block(move || actions::load_courses(&conn))
        .await
        .map_err(|e| {
            eprintln!("{}", e);
            HttpResponse::InternalServerError().finish()
        })?;
    Ok(HttpResponse::Ok().json(courses))
}

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
            .service(get_all_courses)
    })
    .bind(&bind)?
    .run()
    .await
}
