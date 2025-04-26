import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "./models/main.tsp";
import "./models/error.tsp";
import "./models/response.tsp";
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

@service(#{ title: "Pet Store API" })
@server("https://example.com", "Single server endpoint")
@versioned(Versions)
namespace PetStore {
    enum Versions {
        v1: "1.0.0",
    }
    @route("/pets")
    interface Pets {
        @get
        getAllPets(@query filter: string): PetListResponse;
        @get
        getPetById(
            @path id: string,
        ): PetResponse | PetUnauthorizedResponse | PetNotFoundResponse;

        @post
        @useAuth(BearerAuth)
        create(@body pet: Pet):
            | PetCreatedResponse
            | PetAcceptedResponse
            | PetErrorResponse
            | PetUnauthorizedResponse
            | InternalServerErrorResponse;

        @put
        @useAuth(BearerAuth)
        updatePet(@path petId: int32, @body pet: Pet):
            | PetResponse
            | PetErrorResponse
            | PetUnauthorizedResponse
            | PetNotFoundResponse
            | InternalServerErrorResponse;

        @delete
        @useAuth(BearerAuth)
        @opExample(#{
            parameters: #{ petId: 3 },
            returnType: #{ statusCode: 204 },
        })
        deletePet(@path petId: int32):
            | PetResponse
            | PetNotFoundResponse
            | PetNoContentResponse
            | PetUnauthorizedResponse;
    }

    @route("/stores")
    interface Stores {
        @get
        list(@query filter: string): StoreListResponse;

        @get
        read(@path id: int32): StoreResponse | StoreNotFoundResponse;
    }
}
