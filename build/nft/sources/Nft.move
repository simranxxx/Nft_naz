module NFT::Nft{

    //these are the basic imports of the lib used in aptos
    use std::vector;
    use std::string::String;
    use std::signer;
    
    //this is the basic struct of nft. nft are non fungible tokens just like property signed in someones account
    //this contains name owner and the url of the image being posted and is stored in ipfs.
    struct Nft has key,store{
        name:String,
        owner:address,
        url:String,
    }

    //this is the struct of User. struct is like a blueprint of house that consist of how the the architecture of house is to be made.
    struct User has key{
        storage:vector<Nft>
    }

    //these are the function that will be called by front end.
    //Public here justifies that this function can be called outside the module.
    // this function initialises 
    public entry fun init_storage(creator:&signer){
        let storage:User = User{
            storage:vector::empty<Nft>()
        };
        move_to<User>(creator,storage)
    }

    public entry fun map(creator:&signer,url:String,name:String) acquires User{
        let user = borrow_global_mut<User>(signer::address_of(creator));
        let storage = &mut user.storage;
        let nft = Nft{
            name:name,
            owner:signer::address_of(creator),
            url:url,
        };
        vector::push_back<Nft>(storage,nft);

    }







}