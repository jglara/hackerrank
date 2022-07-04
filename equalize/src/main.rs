use std::io;
use std::collections::HashMap;

fn main() -> Result<(), std::io::Error> {
    let mut arr_size = String::new();    
    io::stdin().read_line(&mut arr_size)?;

    let mut arr = String::new();    
    io::stdin().read_line(&mut arr)?;


    let m : HashMap<i32, usize> = arr.split_whitespace()
	.map(|ele| ele.parse::<i32>().expect("Parse error"))
	.fold(HashMap::new(), |mut m_ac, x| { *m_ac.entry(x).or_insert(0) += 1; m_ac });

    let max_count = m.values().max().unwrap();
    let total: usize = m.values().sum();
    let res = total - max_count;

    println!("{}", res);
    
    Ok(())
}
