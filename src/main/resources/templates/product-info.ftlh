<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <a href="/">
            <span class="navbar-brand mb-0 h1">SHOP</span>
        </a>

        <#if user.email??>
            <form action="/" method="get">
                <div class="input-group w-125">
                    <input type="search" name="title" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                    <button type="submit" class="btn btn-outline-primary">search</button>
                </div>
            </form>
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

            <form action="/" method="get">
                <div class="input-group w-125">
                    <input type="search" name="title" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                    <button type="submit" class="btn btn-outline-primary">search</button>
                </div>
            </form>
            <button class="btn btn-light my-2 my-sm-0" type="button"
                    onclick="window.location.href = '/login'">
                Sign in
            </button>
        </#if>
    </div>
</nav>
<br>
<div class="container bootdey">
    <div class="col-md-12">
        <section class="panel">
            <div class="panel-body">
                <div class="col-md-6">
                    <div class="pro-img-details" >
                        <img src="/images/${product.previewImageId}" height="400px" width="1000px" alt="">
                    </div>
                    <div class="pro-img-list" >
                        <#list images as img>
                        <img src="/images/${img.id}" height="100px" alt="photo">
                        </#list>
                    </div>
                </div>
                <div class="col-md-6">
                    <h4 class="pro-d-title">
                        ${product.title}
                    </h4>
                    <p>
                        <strong>Description: </strong> ${product.description}
                    </p>
                    <div class="m-bot15"> <strong>City : </strong><span class="pro-price"> ${product.city}</span></div>
                    <div class="m-bot15"> <strong>Author : </strong><span class="pro-price"><a href="/user/${product.user.id}">${product.user.name}</a></span></div>
                    <div class="m-bot15"> <strong>Price : </strong><span class="pro-price"> ${product.price}</span></div>
                    <br>
                    <p>
                    <#if user.id??>
                    <form action="/product/${product.id}/cart" method="post">
<#--                        <button class="btn btn-round btn-success" type="button" onclick="window.location.href = '/product/${product.id}/cart'"><i class="fa fa-shopping-cart"></i> Add to Cart</button>-->
                        <button type="submit" class="btn btn-round btn-success m-3">Add to Cart</button>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    </form>
                        <#if product.user.id == user.id || user.isAdmin()>
                        <button class="btn btn-round btn-primary" type="button" onclick="window.location.href = '/product/${product.id}/update'"><i class="fa fa-shopping-cart"></i>Edit</button>
                    <form action="/product/${product.id}/delete" method="post">
                        <button type="submit" class="btn btn-round btn-danger m-3">Delete</button>
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    </form>
                    </#if>
                    </#if>
                    </p>
                </div>
            </div>
        </section>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
</body>
</html>