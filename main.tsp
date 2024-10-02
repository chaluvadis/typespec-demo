import "@typespec/http";
import "./models/main.tsp";

using TypeSpec.Http;
@route("/pets")
interface Pets {
    @get
    @opExample(#{
        parameters: #{ filter: "Max" },
        returnType: #[#{ name: "Max", age: 3, kind: petType.dog }],
    })
    getAllPets(@query filter: string): Pet[];

    @post
    @opExample(#{
        parameters: #{ pet: #{ name: "Max", age: 3, kind: petType.dog } },
    })
    create(@body pet: Pet): {
        @statusCode statusCode: 201;
        @body newPet: Pet;
    } | {
        @statusCode statusCode: 202;
        @body acceptedPet: Pet;
    };

    @get
    @opExample(#{ parameters: #{ id: "3" } })
    getPetById(@path id: string): {
        @statusCode statusCode: 200;
        @body pet: Pet;
    } | {
        @statusCode statusCode: 404;
    };

    @put
    updatePet(@path petId: int32, @body pet: Pet): {
        @statusCode statusCode: 200;
        @body updatedPet: Pet;
    } | {
        @statusCode statusCode: 404;
    };

    @delete
    deletePet(@path petId: int32): {
        @statusCode statusCode: 204;
    };
}

@route("/stores")
interface Stores {
    list(@query filter: string): Store[];
    read(@path id: string): Store;
}
