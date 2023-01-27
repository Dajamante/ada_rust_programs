#[repr(u8)]
// fieldless enums: https://doc.rust-lang.org/reference/type-layout.html?highlight=enum#primitive-representation-of-field-less-enums
// repr u16 si la taille ne suffit pas
// faire les types avec des inner fields later
#[derive(Clone, Copy)]
pub enum TwoNumbers {
    One,
    Two,
}

#[no_mangle]
// un enum est normalement en scalaire
// how does Rust pass enums
// controler la taille mémoire
// quelle est la taille des énumérations
// entier sous jacent: GNAT va prendre l'entier signé le plus petit
// moins de 128 valeurs --> 8 bits
// faire expérience avec bigger size
// comment forcer la même taille côté Rust et côté SPARK
// ca sera toujours aligné ? quand paramètres
// comment les choses sont passées pour que l'ABI reste la même
// comment les choses sont mises sur la pile
extern "C" fn swap_enum(one: &mut TwoNumbers, two: &mut TwoNumbers) {
    let tmp = *one;
    *one = *two;
    *two = tmp;
}
