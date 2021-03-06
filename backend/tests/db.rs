use backend::actions;
use diesel::{r2d2::ConnectionManager, PgConnection};

#[test]
fn test_get_courses() {
    dotenv::dotenv().ok();
    let connspec = std::env::var("DATABASE_TEST_URL").expect("No test database url provided");
    let manager = ConnectionManager::<PgConnection>::new(connspec);
    let pool = r2d2::Pool::builder()
        .build(manager)
        .expect("Failed to create a database pool");
    let conn = pool
        .get()
        .expect("Could not retrieve a connection from the pool");
    let courses = actions::load_courses(&conn).unwrap();
    assert_eq!(courses.len(), 77);
}
