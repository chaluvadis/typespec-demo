import "@typespec/http";
import "@typespec/openapi3";
import "./models/main.tsp";
import "./models/error.tsp";
using TypeSpec.Http;

@service(#{ title: "Pet Store API" })
@server("https://example.com", "Single server endpoint")
namespace PetStore {
    @route("/pets")
    interface Pets {
        @get
        @opExample(#{
            parameters: #{ filter: "Max" },
            returnType: #{
                statusCode: 200,
                pets: #[#{ id: 123, name: "Max", age: 3, kind: petType.dog }],
            },
        })
        getAllPets(@query filter: string): {
            @statusCode statusCode: 200;
            @body pets: Pet[];
        };

        @post
        @opExample(#{
            parameters: #{
                pet: #{ id: 123, name: "Max", age: 3, kind: petType.dog },
            },
            returnType: #{
                statusCode: 201,
                pet: #{ id: 123, name: "Max", age: 3, kind: petType.dog },
            },
        })
        create(@body pet: Pet):
            | {
                  @statusCode statusCode: 201;
                  @body pet: Pet;
              }
            | {
                  @statusCode statusCode: 202;
                  @body pet: Pet;
              }
            | {
                  @statusCode statusCode: 400;
                  @body error: ValidationError;
              }
            | {
                  @statusCode statusCode: 500;
                  @body error: InternalServerError;
              };

        @get
        @opExample(#{
            parameters: #{ id: "3" },
            returnType: #{
                statusCode: 200,
                pet: #{ id: 123, name: "Max", age: 23, kind: petType.bird },
            },
        })
        getPetById(@path id: string): {
            @statusCode statusCode: 200;
            @body pet: Pet;
        } | {
            @statusCode statusCode: 404;
            @body error: NotFoundError;
        };

        @put
        @opExample(#{
            parameters: #{
                petId: 3,
                pet: #{ id: 123, name: "Max", age: 23, kind: petType.bird },
            },
            returnType: #{
                statusCode: 200,
                pet: #{ id: 123, name: "Max", age: 23, kind: petType.bird },
            },
        })
        updatePet(@path petId: int32, @body pet: Pet):
            | {
                  @statusCode statusCode: 200;
                  @body pet: Pet;
              }
            | {
                  @statusCode statusCode: 404;
                  @body error: ValidationError;
              }
            | {
                  @statusCode statusCode: 400;
                  @body error: ValidationError;
              }
            | {
                  @statusCode statusCode: 500;
                  @body error: InternalServerError;
              };

        @delete
        @opExample(#{
            parameters: #{ petId: 3 },
            returnType: #{ statusCode: 204 },
        })
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
                        id: 123,
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
            parameters: #{ id: 3 },
            returnType: #{
                id: 123,
                name: "Max",
                address: #{ street: "abc street", city: "xyz city" },
            },
        })
        read(@path id: int32): Store;
    }
}
