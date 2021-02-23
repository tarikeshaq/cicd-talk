use crate::models;
use diesel::prelude::*;

pub fn load_courses(conn: &PgConnection) -> Result<Vec<models::Course>, diesel::result::Error> {
    use crate::schema::courses::dsl::*;

    courses.load::<models::Course>(conn)
}
