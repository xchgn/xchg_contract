module xchg::xchg;

use sui::package;
use sui::display;
use xchg::fund;

public struct XCHG has drop {}
fun init(otw: XCHG, ctx: &mut TxContext) {
	let keys = vector[
		b"name".to_string(),
		b"link".to_string(),
		b"image_url".to_string(),
		b"description".to_string(),
		b"project_url".to_string(),
		b"creator".to_string(),
	];

    let values = vector[
        b"{header}".to_string(),
        b"https://xchg.network/".to_string(),
        b"https://xchg.network/public/icons/logo64.png".to_string(),
        b"Peer-To-Peer Network".to_string(),
        b"https://xchg.network/".to_string(),
        b"XCHG Creator".to_string(),
    ];

	let publisher = package::claim(otw, ctx);
	let mut display = display::new_with_fields<fund::Fund>(
        &publisher, keys, values, ctx
    );

	display.update_version();
	transfer::public_transfer(publisher, ctx.sender());
    transfer::public_transfer(display, ctx.sender());

	// Create default fund
	fund::create_fund(ctx);
}
