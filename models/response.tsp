import "@typespec/http";
import "./main.tsp";
import "./error.tsp";
using TypeSpec.Http;

model PetListResponse {
    ...OkResponse;
    ...Body<Pet[]>;
}

model PetResponse {
    ...OkResponse;
    ...Body<Pet>;
}

model PetCreatedResponse {
    ...CreatedResponse;
    ...Body<Pet>;
}

model PetAcceptedResponse {
    ...AcceptedResponse;
    ...Body<Pet>;
}

model PetErrorResponse {
    ...BadRequestResponse;
    ...Body<ValidationError>;
}

model PetNotFoundResponse {
    ...NotFoundResponse;
    ...Body<NotFoundError>;
}

model PetUnauthorizedResponse {
    ...UnauthorizedResponse;
    ...Body<UnauthorizedError>;
}
model PetSuccessResponse {
    ...OkResponse;
    ...Body<string>;
}

model PetNoContentResponse {
    ...NoContentResponse;
}

model InternalServerErrorResponse {
    @statusCode statusCode: 500;
    @body error: InternalServerError;
}

model StoreListResponse {
    ...OkResponse;
    ...Body<Store[]>;
}

model StoreResponse {
    ...OkResponse;
    ...Body<Store>;
}

model StoreNotFoundResponse {
    ...NotFoundResponse;
    ...Body<NotFoundError>;
}
