import "@typespec/http";
import "./models/main.tsp";

using TypeSpec.Http;
@route("/pets")
interface Pets {
    @get
    @opExample(#{
        parameters: #{ filter: "Max" },
        returnType: #{
            statusCode: 200,
            pets: #[#{ name: "Max", age: 3, kind: petType.dog }],
        },
    })
    getAllPets(@query filter: string): {
        @statusCode statusCode: 200;
        @body pets: Pet[];
    };

    @post
    @opExample(#{
        parameters: #{ pet: #{ name: "Max", age: 3, kind: petType.dog } },
        returnType: #{
            statusCode: 201,
            pet: #{ name: "Max", age: 3, kind: petType.dog },
        },
    })
    create(@body pet: Pet): {
        @statusCode statusCode: 201;
        @body pet: Pet;
    } | {
        @statusCode statusCode: 202;
        @body pet: Pet;
    };

    @get
    @opExample(#{
        parameters: #{ id: "3" },
        returnType: #{
            statusCode: 200,
            pet: #{ name: "Max", age: 23, kind: petType.bird },
        },
    })
    getPetById(@path id: string): {
        @statusCode statusCode: 200;
        @body pet: Pet;
    } | {
        @statusCode statusCode: 404;
    };

    @put
    @opExample(#{
        parameters: #{
            petId: 3,
            pet: #{ name: "Max", age: 23, kind: petType.bird },
        },
        returnType: #{
            statusCode: 200,
            pet: #{ name: "Max", age: 23, kind: petType.bird },
        },
    })
    updatePet(@path petId: int32, @body pet: Pet): {
        @statusCode statusCode: 200;
        @body pet: Pet;
    } | {
        @statusCode statusCode: 404;
    };

    @delete
    @opExample(#{ parameters: #{ petId: 3 }, returnType: #{ statusCode: 204 } })
    deletePet(@path petId: int32): {
        @statusCode statusCode: 204;
    };
}

@route("/stores")
interface Stores {
    @get
    @opExample(#{
        parameters: #{ filter: "Max" },
        returnType: #{
            statusCode: 200,
            stores: #[
                #{
                    name: "abc store",
                    address: #{ street: "123 street", city: "xyz city" },
                }
            ],
        },
    })
    list(@query filter: string): {
        @statusCode statusCode: 200;
        @body stores: Store[];
    };

    @get
    @opExample(#{
        parameters: #{ id: "3" },
        returnType: #{
            name: "Max",
            address: #{ street: "abc street", city: "xyz city" },
        },
    })
    read(@path id: string): Store;
}
