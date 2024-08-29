use std::fs::OpenOptions;
use std::io::{Seek, SeekFrom, Write};
use std::time::Instant;

fn patch_file(filename: &str, bytes: &[u8], offset: u64) -> std::io::Result<()> {
    let mut file = OpenOptions::new().read(true).write(true).open(filename)?;
    file.seek(SeekFrom::Start(offset))?;
    file.write_all(bytes)?;
    Ok(())
}

fn main() {
    let start = Instant::now();
    let filename = "randomblock";
    let bytes = b"d1ffd1ff";
    let offset = 100;
    
    if let Err(e) = patch_file(filename, bytes, offset) {
        eprintln!("Error: {}", e);
    }

    let duration = start.elapsed();
    println!("Time taken: {:?} (rust)", duration);
}