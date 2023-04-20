use bbqueue::{BBBuffer, Consumer, Producer};
use std::{sync::Arc, thread};

static BB: BBBuffer<6> = BBBuffer::new();

fn main() {
    // Create a buffer with six elements
    let (mut prod, mut cons) = BB.try_split().unwrap();

    let tx = thread::spawn(move || {
        producing(prod);
    });

    let rx = thread::spawn(move || {
        reading(cons);
    });
    tx.join();
    rx.join();
}

fn reading(mut cons: Consumer<6>) {
    // Read all available bytes

    loop {
        match cons.read() {
            Ok(rgr) => {
                println!("{:?}", rgr);

                // Release the space for later writes
                rgr.release(2);
            }
            Err(e) => {
                //println!("{:?}", e);
            }
        }
    }
}

fn producing(mut prod: Producer<6>) {
    // Request space for one byte
    loop {
        //let mut wgr = prod.grant_exact(2).unwrap();

        match prod.grant_exact(2) {
            Ok(mut wgr) => {
                wgr[0] = 123;
                wgr[1] = 124;

                // Make the data ready for consuming
                wgr.commit(2);
            }
            Err(e) => {
                //println!("{:?}", e);
            }
        }
    }
}
