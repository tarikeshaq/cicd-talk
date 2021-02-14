table! {
    courses (name, number) {
        name -> Text,
        number -> Text,
    }
}

table! {
    enrollments (user_id, course_name, course_number) {
        user_id -> Int4,
        course_name -> Text,
        course_number -> Text,
    }
}

table! {
    prereqs (course_name, course_number, prereq_name, prereq_number) {
        course_name -> Text,
        course_number -> Text,
        prereq_name -> Text,
        prereq_number -> Text,
    }
}

table! {
    users (id) {
        id -> Int4,
        name -> Text,
    }
}

joinable!(enrollments -> users (user_id));

allow_tables_to_appear_in_same_query!(
    courses,
    enrollments,
    prereqs,
    users,
);
