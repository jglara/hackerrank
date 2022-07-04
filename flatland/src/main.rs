use std::io;
use std::cmp;

fn main() -> io::Result<()> {

    let mut line = String::new();

    io::stdin().read_line(&mut line)?;
    let n: u32 = line.split_whitespace().next().unwrap().parse::<_>().unwrap();

    line.clear();
    io::stdin().read_line(&mut line)?;
    let mut sta: Vec<u32> = line.split_whitespace()
        .map(|tok| tok.parse::<u32>().unwrap())
        .collect::<_>();

    sta.sort();

    let first = sta[0];
    let last = sta[sta.len()-1];

    let mut max: u32 = 0;

    if sta.len() > 1 {
	max = sta.iter().zip(sta[1..].iter())
	    .map(|(a,b)| (b-a)/2)
	    .max()
	    .expect("Empty list");
    }

    max = cmp::max(first, max);
    max = cmp::max(n - last - 1, max);


    println!("{}", max);

    Ok(())
}
