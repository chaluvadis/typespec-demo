@error
model NotFoundError {
    code: "NOT_FOUND";
    message: string;
}

@error
model ValidationError {
    code: "VALIDATION_ERROR";
    message: string;
    details: string[];
}

@error
model InternalServerError {
    code: "INTERNAL_SERVER_ERROR";
    message: string;
}

@error
model UnauthorizedError {
    code: "UNAUTHORIZED";
    message: string;
}
