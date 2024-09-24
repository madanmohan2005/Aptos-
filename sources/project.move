module MyModule::P2PLoanSystem {

    use aptos_framework::coin;
    use aptos_framework::aptos_coin::{AptosCoin};
    use aptos_framework::signer;

    struct Loan has store, key {
        lender: address,
        borrower: address,
        amount: u64,
    }

    // Function to lend tokens from the lender to the borrower
    public fun lend_tokens(lender: &signer, borrower: address, amount: u64) {
        coin::transfer<AptosCoin>(lender, borrower, amount);
        move_to(lender, Loan {
            lender: signer::address_of(lender),
            borrower,
            amount,
        });
    }

    // Function to repay the loan back to the lender
    public fun repay_loan(borrower: &signer, lender: address, amount: u64) {
        coin::transfer<AptosCoin>(borrower, lender, amount);
    }
}
