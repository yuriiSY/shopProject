<#import "pager.ftlh" as p>
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
        <form action="/search" method="get">
            <div class="input-group w-125">
                <input type="search" name="title" value="${title?ifExists}" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                <button type="submit" class="btn btn-outline-primary">search</button>
            </div>
        </form>
        <#if user.email??>
            <div class=" d-flex flex-wrap">
            <button type="button" class="btn btn-primary"  onclick="window.location.href = '/cart'">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
                    <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                </svg>
                Cart
            </button>
            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button class="btn btn-light my-2 my-sm-0" type="submit" value="Exit"
                    onclick="window.location.href = '/logout'">
                Log out
                </button>
            </form>
            </div>
        <#else>
            <button class="btn btn-light my-2 my-sm-0" type="button"
                    onclick="window.location.href = '/login'">
                Sign in
            </button>
        </#if>
    </div>
</nav>

<#if user.email??>
<div class="accordion" id="accordionExample">
    <div class="accordion-item">
        <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                Add Product
            </button>
        </h2>
        <div id="collapseOne" class="accordion-collapse collapse show " aria-labelledby="headingOne" data-bs-parent="#accordionExample">
            <div class="accordion-body row justify-content-center">
                <h3>Create new Product</h3>
                <form action="/product/create" method="post" enctype="multipart/form-data" >
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Title</label>
                        <input type="text" name="title" <#if titleError??>value="${product.title}</#if>" class="form-control ${(titleError??)?string('is-invalid', '')}" id="exampleFormControlInput1" placeholder="Car">

                        <#if titleError??>
                        <div class="invalid-feedback">
                            asd
                            ${titleError}
                        </div>
                        </#if>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Description</label>
                        <input type="text" name="description" <#if descriptionError??>value="${product.description}"</#if> class="form-control ${(descriptionError??)?string('is-invalid', '')}" id="exampleFormControlInput1" placeholder="good car">
                        <#if descriptionError??>
                            <div class="invalid-feedback">
                                ${descriptionError}
                            </div>
                        </#if>
                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">City</label>
                        <input type="text" name="city" <#if cityError??>value="${product.city}"</#if> class="form-control ${(cityError??)?string('is-invalid', '')}" id="exampleFormControlInput1" placeholder="London">
                        <#if cityError??>
                            <div class="invalid-feedback">
                                ${cityError}
                            </div>
                        </#if>

                    </div>
                    <div class="form-group">
                        <label for="exampleFormControlInput1">Price</label>
                        <input type="number" required name="price" class="form-control" id="exampleFormControlInput1" placeholder="20000">
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlFile1">Main Photo</label><br>
                        <input type="file" required name="file1" class="form-control-file" id="exampleFormControlFile1">
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
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Add product"/>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href = '/user/${user.id}'">Account</button>
<#if user.isAdmin()>
    <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href = '/admin'">Panel Admin</button>
</#if>
<button type="button" class="btn btn-secondary btn-lg btn-block" onclick="window.location.href = '/orders-info/${user.id}'">Orders</button>
</#if>
<div class="container mt-4 d-flex align-content-end flex-wrap justify-content-center">
    <div class="btn-group">
        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/price-desc'">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-up" viewBox="0 0 16 16">
                <path d="M3.5 12.5a.5.5 0 0 1-1 0V3.707L1.354 4.854a.5.5 0 1 1-.708-.708l2-1.999.007-.007a.498.498 0 0 1 .7.006l2 2a.5.5 0 1 1-.707.708L3.5 3.707V12.5zm3.5-9a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"/>
            </svg>
            <span class="visually-hidden">Button</span>
        </button>
        <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/price-asc'">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-sort-down" viewBox="0 0 16 16">
                <path d="M3.5 2.5a.5.5 0 0 0-1 0v8.793l-1.146-1.147a.5.5 0 0 0-.708.708l2 1.999.007.007a.497.497 0 0 0 .7-.006l2-2a.5.5 0 0 0-.707-.708L3.5 11.293V2.5zm3.5 1a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zM7.5 6a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zm0 3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zm0 3a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1h-1z"/>
            </svg>
            <span class="visually-hidden">Button</span>
        </button>
    </div>
<@p.pager URL products/>


    <#list products.content as product>
    <div class="card" style="width: 18rem;">
        <img src="/images/${product.previewImageId}" class="card-img-top" >
        <div class="card-body">
            <h5 class="card-title">${product.title}</h5>
            <p class="card-text">${product.description}</p>
            <a href="/product/${product.id}" class="btn btn-primary">More</a>
        </div>
    </div>
<#else>
    <h3>No products</h3>
</#list>
    </div>
<@p.pager URL products/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
</body>
</html>