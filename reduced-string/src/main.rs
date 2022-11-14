use std::io;

fn reduce_string(line: &str) -> String {

    let output = line.chars().fold(String::new(), |mut acum, c| {
	if let Some(last) = acum.pop() {
	    if last !=c { acum.push(last); acum.push(c);}
	} else {
	    acum.push(c); 
	}
	acum
    });
    

    if output.is_empty() {
	"Empty String".to_string()
    } else {
	output
    }    
}

fn main() -> io::Result<()> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;

    let output = reduce_string(&line);

    println!("{}", output);

    Ok(())
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_1() {
	assert_eq!(reduce_string("aaabccddd"), "abd");
    }

    #[test]
    fn test_2() {
	assert_eq!(reduce_string("aa"), "Empty String");
    }

    #[test]
    fn test_3() {
	assert_eq!(reduce_string("baab"), "Empty String");
    }



}
