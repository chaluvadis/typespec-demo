@doc("This is a simple pet model")
model Pet {
    @visibility(Lifecycle.Read)
    id: int32;

    @minLength(3)
    @maxLength(100)
    name: string;

    @minValue(1)
    @maxValue(100)
    age: int32;

    kind: petType;
}

@doc("This is a simple store model")
model Store {
    @visibility(Lifecycle.Read)
    id: int32;

    @minLength(3)
    @maxLength(100)
    name: string;

    address: Address;
}

@doc("This is a simple address model")
model Address {
    @minLength(3)
    @maxLength(100)
    street: string;

    @minLength(3)
    @maxLength(100)
    city: string;
}

enum petType {
    dog: "dog",
    cat: "cat",
    fish: "fish",
    bird: "bird",
    reptile: "reptile",
}
