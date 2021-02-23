use serde::Serialize;
#[derive(Queryable)]
pub struct User {
    pub id: i32,
    pub name: String,
}

#[derive(Queryable, Serialize)]
pub struct Course {
    pub name: String,
    pub number: String,
}

#[derive(Queryable)]
pub struct Prereq {
    pub course_name: String,
    pub course_number: String,
    pub prereq_name: String,
    pub prereq_number: String,
}

#[derive(Queryable)]
pub struct Enrollment {
    pub user_id: i32,
    pub course_name: String,
    pub course_number: String,
}
