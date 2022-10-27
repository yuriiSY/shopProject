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
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <a href="/">
            <span class="navbar-brand mb-0 h1">SHOP</span>
        </a>
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
    </div>
</nav>

<section class="h-100 gradient-custom">
    <div class="container py-5">
        <div class="row d-flex justify-content-center my-4">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0">Cart Items</h5>
                    </div>
                    <#list cart.cartDetails as detail>
                    <div class="card-body">
                        <!-- Single item -->
                        <div class="row">
                            <div class="col-lg-3 col-md-12 mb-4 mb-lg-0">
                                <div class="bg-image hover-overlay hover-zoom ripple rounded" data-mdb-ripple-color="light">
                                    <img src="/images/${detail.preview}"
                                         class="w-100" alt="Blue Jeans Jacket" />
                                </div>
                            </div>

                            <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                                <!-- Data -->
                                <p><strong>${detail.title}</strong></p>
                                <!-- Data -->
                            </div>

                            <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                                <div class="d-flex mb-4" style="max-width: 300px">
                                    <div class="form-outline">
                                        <label class="form-label" for="form1">Quantity:</label>
                                        <p><strong>${detail.amount}</strong></p>
                                    </div>
                                </div>
                                <div class="d-flex mb-4" style="max-width: 300px">
                                    <div class="form-outline">
                                        <label class="form-label" for="form1">Price for one product:</label>
                                        <p><strong>${detail.price}</strong></p>
                                    </div>
                                </div>
                                <div class="d-flex mb-4" style="max-width: 300px">
                                    <div class="form-outline">
                                        <label class="form-label" for="form1">Total:</label>
                                        <p><strong>${detail.sum}</strong></p>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-danger btn-lg btn-block" onclick="window.location.href = '/cart/delete/${detail.productId}'">
                                    Delete One
                                </button>
                            </div>
                        </div>

                        <hr class="my-4" />
                    </div>
                    </#list>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header py-3">
                        <h5 class="mb-0">Summary</h5>
                    </div>
                    <#if cart.sum??>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                                <div>
                                    <strong>Total amount</strong>
                                </div>
                                <span><strong>${cart.sum}</strong></span>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-primary btn-lg btn-block" onclick="window.location.href = '/cart/order'">
                            Go to checkout
                        </button>
                        <form action="/cart/clear" method="post">
                            <button type="submit" class="btn btn-round btn-danger m-3">Clear Cart</button>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        </form>

                    </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
    </body>
</html>