 create table "cart" (
     "id" int8 generated by default as identity,
     "user_id" int8,
     primary key ("id")
);
 create table "order" (
     "id" int8 generated by default as identity,
     "date_of_created" timestamp,
     "status" boolean not null,
     "total_price" float8 not null,
      "user_id" int8,
       primary key ("id")
 );
 create table "cart_products" (
     "cart_id" int8 not null,
      "product_id" int8 not null
                              );
 create table "images" (
     "id" int8 generated by default as identity,
      "bytes" bytea,
       "content_type" varchar(255),
        "is_preview_image" boolean,
         "name" varchar(255),
          "original_file_name" varchar(255),
           "size" int8,
            "product_id" int8,
             primary key ("id")
                       );
 create table "order_products" (
     "order_id" int8 not null,
      "product_id" int8 not null
                               );
 create table "products" (
     "id" int8 not null,
     "city" varchar(255),
     "date_of_created" timestamp,
      "description" "text",
       "preview_image_id" int8,
        "price" int4,
         "title" varchar(255),
          "user_id" int8,
           primary key ("id")
                         );
create table "user_role" (
    "user_id" int8 not null,
    "roles" varchar(255)
                         );
 create table "users" (
     "id" int8 generated by default as identity,
      "active" boolean,
       "date_of_created" timestamp,
        "email" varchar(255),
         "name" varchar(255),
          "password" varchar(1000),
           "phone_number" varchar(255),
            "image_id" int8,
             "cart_id" int8,
              primary key ("id")
                      );
 alter table if exists "users"
     add constraint UK_6dotkott2kjsp8vw4d0m25fb7 unique ("email");
 alter table if exists "cart"
     add constraint "FKa10mmlavm34n720q8rnc4ufc8"
     foreign key ("user_id") references "users";
 alter table if exists "order"
     add constraint "FKrby37m01iggqlorjvht8k44q7"
     foreign key ("user_id") references "users";
 alter table if exists "cart_products"
     add constraint "FKpusuhrydj1ogiekh0u0478yyc"
     foreign key ("product_id") references "products";
 alter table if exists "cart_products"
     add constraint "FKa2rha8g45kontrwwbklxa4mxm"
     foreign key ("cart_id") references "cart";
 alter table if exists "images"
     add constraint "FKr3qm4mhy2l4tjfugowdorbmt4"
     foreign key ("product_id") references "products";
 alter table if exists "order_products"
     add constraint "FKhejciolatynfv56br6kq3ldrj"
     foreign key ("product_id") references "products";
 alter table if exists "order_products"
     add constraint "FK633bum8bdtjbbsld4ef061y64"
     foreign key ("order_id") references "order";
 alter table if exists "products"
     add constraint "FKilfj7j028e383cm3g0h1ch18w"
     foreign key ("user_id") references "users";
 alter table if exists "user_role"
     add constraint "FKpwfddxbsye75keansxohc42l"
     foreign key ("user_id") references "users";
 alter table if exists "users"
     add constraint "FKqtpw5tp3epx32py7476pti00l"
     foreign key ("image_id") references "images";
 alter table if exists "users"
     add constraint "FKox38scwvtdj29cad617o65yy7"
     foreign key ("cart_id") references "cart";