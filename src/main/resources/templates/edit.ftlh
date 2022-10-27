<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
          crossorigin="anonymous">
    <link rel="stylesheet" href=
    "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"/>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <a href="/">
            <span class="navbar-brand mb-0 h1">SHOP</span>
        </a>
        <div class=" d-flex flex-wrap">
            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button class="btn btn-light my-2 my-sm-0" type="submit" value="Exit"
                        onclick="window.location.href = '/logout'">
                    Log out
                </button>
            </form>
        </div>
    </div>
</nav>

<div id="collapseOne" class="accordion-collapse collapse show " aria-labelledby="headingOne" data-bs-parent="#accordionExample">
    <div class="accordion-body row justify-content-center">
        <h3>Edit Product: ${product.title}</h3>
        <form action="/product/update/edit" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="exampleFormControlInput1">Title</label>
                <input type="text" name="title" class="form-control" id="exampleFormControlInput1" placeholder="Car" value="${product.title}">
            </div>
            <div class="form-group">
                <label for="exampleFormControlInput1">Description</label>
                <input type="text" name="description" class="form-control" id="exampleFormControlInput1" placeholder="good car" value="${product.description}">
            </div>
            <div class="form-group">
                <label for="exampleFormControlInput1">City</label>
                <input type="text" name="city" class="form-control" id="exampleFormControlInput1" placeholder="London" value="${product.city}">
            </div>
            <div class="form-group">
                <label for="exampleFormControlInput1">Price</label>
                <input type="number" name="price" class="form-control" id="exampleFormControlInput1" placeholder="20000">
            </div>
            <div class="form-group">
                <label for="exampleFormControlFile1">Photo</label><br>
                <input type="file" name="file1" class="form-control-file" id="exampleFormControlFile1">
            </div>
            <div class="form-group">
                <label for="exampleFormControlFile1">Photo</label><br>
                <input type="file" name="file2" class="form-control-file" id="exampleFormControlFile1">
            </div>
            <div class="form-group">
                <label for="exampleFormControlFile1">Photo</label><br>
                <input type="file" name="file3" class="form-control-file" id="exampleFormControlFile1">
            </div>
            <div class="form-group">
                <br>
                <input type="hidden" value="${product.id}" name="productId">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Add product"/>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
</body>
</body>
</html>