use chrono::NaiveDate;
use polars::prelude::*;

fn main() {
    series();
    dataframe()
}

fn series() {
    let s = Series::new("a", [1, 2, 3, 4, 5]);
    println!("{}", s);
}

fn dataframe() {
    let df: DataFrame = df!("integer" => &[1, 2, 3, 4, 5],
    "date" => &[
                NaiveDate::from_ymd_opt(2022, 1, 1).unwrap().and_hms_opt(0, 0, 0).unwrap(),
                NaiveDate::from_ymd_opt(2022, 1, 2).unwrap().and_hms_opt(0, 0, 0).unwrap(),
                NaiveDate::from_ymd_opt(2022, 1, 3).unwrap().and_hms_opt(0, 0, 0).unwrap(),
                NaiveDate::from_ymd_opt(2022, 1, 4).unwrap().and_hms_opt(0, 0, 0).unwrap(),
                NaiveDate::from_ymd_opt(2022, 1, 5).unwrap().and_hms_opt(0, 0, 0).unwrap()
    ],
    "float" => &[4.0, 5.0, 6.0, 7.0, 8.0]
    )
    .expect("should not fail");
    println!("{}", df);
    println!("{}", df.head(Some(3)));
    println!("{}",df.tail(Some(3)));
}
