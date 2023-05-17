use sqlx::Connection;
use sqlx::Row;
use std::error::Error;
// use sqlx::postgres::PgPoolOptions;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    // dotenv::dotenv().expect("Unable to load environment variables from .env file");
    // let db_url = std::env::var("DATABASE_URL").expect("Unable to read DATABASE_URL env var");
    let url = "postgres://craole@localhost:5432/nba";
    let mut conn = sqlx::postgres::PgConnection::connect(url).await?;

    let res = sqlx::query("SELECT 1 + 1 AS sum")
        .fetch_one(&mut conn)
        .await?;

    let sum: i32 = res.get("sum");
    println!("1 + 1 = {}", sum);

    Ok(())
}
