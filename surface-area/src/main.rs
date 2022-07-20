use std::io;


fn count_exposed_surface<'a, I>(it: I) -> u32
    where I: Iterator<Item = &'a u32>,
{
    it.scan(0, |last, &ele| {
	let diff = if ele > *last { ele - *last } else { 0 };
	*last = ele ;
	Some(diff)
    }).sum()

}



fn transpose<T>(v: &Vec<Vec<T>>) -> Vec<Vec<T>>
where
    T: Clone,
{
    assert!(!v.is_empty());
    (0..v[0].len())
        .map(|i| v.iter().map(|inner| inner[i].clone()).collect::<Vec<T>>())
        .collect()
}


fn main() -> io::Result<()> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    let dims : Vec<u32> = line.split_ascii_whitespace().map(|ele| ele.parse::<_>().expect("Parse error")).collect::<_>();

    let mut grid: Vec< Vec<u32>> = Vec::new();
    for _ in 0..dims[0] {
	line.clear();
	io::stdin().read_line(&mut line)?;
	grid.push(line.split_ascii_whitespace().map(|ele| ele.parse::<u32>().expect("Parse error")).collect::<_>());
    }

    let grid_transpose = transpose(&grid);


//    println!("{:?}", grid);
//    println!("{:?}", grid_transpose);
    
    println!("{:?}", vec![
	dims[0]*dims[1],
	dims[0]*dims[1],
	grid.iter().map(|v| {count_exposed_surface(v.iter())} ).sum::<_>(),
	grid.iter().map(|v| {count_exposed_surface(v.iter().rev())} ).sum::<_>(),
	grid_transpose.iter().map(|v| {count_exposed_surface(v.iter())} ).sum::<_>(),
	grid_transpose.iter().map(|v| {count_exposed_surface(v.iter().rev())} ).sum::<_>(),	
	].iter().sum::<u32>());

    Ok(())
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_1() {
	let v1 = vec![1, 3, 4];
	assert_eq!(count_exposed_surface(v1.iter()), 1+2+1);
    }

    #[test]
    fn test_2() {
	let v1 = vec![1, 3, 2];
	assert_eq!(count_exposed_surface(v1.iter()), 1+2+0);
    }

    #[test]
    fn test_3() {
	let v1 = vec![4, 3, 4];
	assert_eq!(count_exposed_surface(v1.iter()), 4+0+1);
    }



}
