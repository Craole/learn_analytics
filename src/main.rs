use std::error::Error;
// use sqlx::Connection;
use sqlx::Row;

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    dotenv::dotenv().expect("Unable to load environment variables from .env file");
    let db_url =
        std::env::var("DATABASE_URL_PRJ1").expect("Unable to read DATABASE_URL_PRJ1 env var");
    let pool = sqlx::postgres::PgPool::connect(&db_url).await?;

    sqlx::migrate!("./migrations").run(&pool).await?;

    let res = sqlx::query("SELECT 1 + 1 AS sum").fetch_one(&pool).await?;

    let sum: i32 = res.get("sum");
    println!("1 + 1 = {}", sum);

    Ok(())
}
