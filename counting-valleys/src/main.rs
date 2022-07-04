use std::io;

fn main() -> io::Result<()> {

    let mut line = String::new();

    io::stdin().read_line(&mut line)?;
    line.clear();

    io::stdin().read_line(&mut line)?;
    let mut level: i32 = 0;
    let res: usize = line.chars()
        .map(|c| if c == 'D' {-1} else {1})
        .map(|x| {level += x ; (level, x)})
        .map(|(l,x)| if l == 0 && x == 1 {1} else {0})
        .sum();

    println!("{}", res);

    Ok(())
    
}
