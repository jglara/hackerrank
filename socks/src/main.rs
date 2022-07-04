use std::io;
use std::collections::HashMap;

fn main() -> io::Result<()> {

    let mut line= String::new();

    // read number of items
    io::stdin().read_line(&mut line)?;
    line.clear();

    // read socks array
    io::stdin().read_line(&mut line)?;
    let mut socks_map: HashMap<u16, usize> = HashMap::new();
    
    line.split_whitespace()
	.map(|s| s.parse::<u16>().unwrap() )
	.for_each(|s| {let count = socks_map.entry(s).or_insert(0); *count+=1;});

    let res: usize = socks_map.iter().map(|(_,v)| v / 2).sum();

    println!("{}", res);

    Ok(())

}
