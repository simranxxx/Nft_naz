module NFT::Nft{

    
    use std::vector;
    use std::string::String;
    use std::signer;


    struct Nft has key,store{
        name:String,
        owner:address,
        url:String,
    }


    struct User has key{
        storage:vector<Nft>
    }


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