use sqlx::Connection;
use sqlx::Row;
use std::error::Error;
// use sqlx::postgres::PgPoolOptions;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    dotenv::dotenv().expect("Unable to load environment variables from .env file");
    let db_url = std::env::var(DATABASE_URL_PRJ1).expect("Unable to read DATABASE_URL_PRJ1 env var");

    let mut conn = sqlx::postgres::PgConnection::connect(&db_url).await?;

    let res = sqlx::query("SELECT 1 + 1 AS sum")
        .fetch_one(&mut conn)
        .await?;

    let sum: i32 = res.get("sum");
    println!("1 + 1 = {}", sum);

    Ok(())
}
